"""把 MIDI 的一段转成 Note Block Studio 风格的 mvpmusic 数据包函数。

用法:
  python tools/midi2nbs.py --midi <file.mid> --song huashang --start 116 --end 157.4 --out <dir>

生成的 <dir>/<song>/ 目录里是 notes/ + tree/ + play/stop/pause/tick/load/uninstall。
"""
import argparse, os, sys, math
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from midi_info import parse

INSTR = {
    0:  ('harp',   0.85, 66),   # Acoustic Grand Piano
    4:  ('harp',   0.75, 66),   # Electric Piano
    27: ('guitar', 0.45, 66),   # Electric Guitar (clean)
    29: ('guitar', 0.50, 66),   # Overdriven Guitar
    32: ('bass',   0.80, 42),   # Acoustic Bass: 音符盒 bass 比 harp 低两个八度
}

DRUM = {
    35: 'basedrum', 36: 'basedrum',
    38: 'snare', 40: 'snare',
    42: 'hat', 44: 'hat', 46: 'hat', 51: 'hat', 53: 'hat', 57: 'hat', 59: 'hat',
    49: 'chime', 52: 'chime',
}


def pitch_for(note, base):
    n = note
    p = 2 ** ((n - base) / 12.0)
    while p < 0.5:
        n += 12
        p = 2 ** ((n - base) / 12.0)
    while p > 2.0:
        n -= 12
        p = 2 ** ((n - base) / 12.0)
    return round(p, 6), n


def build(midi, start_s, end_s, song):
    fmt, div, tracks = parse(midi)
    tempos = sorted([(t, b) for tr in tracks for (k, t, b) in tr['metas'] if k == 'tempo'])
    bpm = tempos[0][1] if tempos else 120.0
    tpq = 20.0 * 60.0 / bpm            # 每四分音符 = 多少游戏刻（20 刻/秒）
    start_tick = start_s * bpm / 60.0 * div
    end_tick = end_s * bpm / 60.0 * div

    events = {}   # game_tick -> list of playsound args
    programs = {}
    for tr in tracks:
        programs.update(tr['progs'])
    for tr in tracks:
        for (tick, kind, note, vel, ch) in tr['notes']:
            if kind != 'on':
                continue
            if not (start_tick <= tick < end_tick):
                continue
            rel = (tick - start_tick) / div * tpq
            gt = int(round(rel))
            if ch == 9:
                inst = DRUM.get(note, 'basedrum')
                vol = 1.0 if inst != 'hat' else 0.7
                pitch = 1.2 if inst == 'hat' else 1.0
            else:
                prog = programs.get(ch, 0)
                inst, vol, base = INSTR.get(prog, INSTR[0])
                pitch, _ = pitch_for(note, base)
            events.setdefault(gt, []).append((inst, round(vol, 3), pitch))
    return events, bpm


def emit(events, song, out):
    root = os.path.join(out, song)
    notes_dir = os.path.join(root, 'notes')
    tree_dir = os.path.join(root, 'tree')
    os.makedirs(notes_dir, exist_ok=True)
    os.makedirs(tree_dir, exist_ok=True)
    maxtick = max(events) if events else 0

    for gt, notes in sorted(events.items()):
        lines = []
        for inst, vol, pitch in sorted(set(notes)):
            lines.append(f'playsound minecraft:block.note_block.{inst} master @s ^0 ^ ^ {vol} {pitch} 1')
        with open(os.path.join(notes_dir, f'{gt}.mcfunction'), 'w', encoding='utf-8', newline='\n') as f:
            f.write('\n'.join(lines) + '\n')

    def build_node(lo, hi):
        ticks = [t for t in events if lo <= t <= hi]
        if not ticks:
            return None
        name = f'{lo}_{hi}'
        path = os.path.join(tree_dir, name + '.mcfunction')
        if hi - lo <= 8:
            with open(path, 'w', encoding='utf-8', newline='\n') as f:
                for t in ticks:
                    f.write(f'execute as @s[scores={{nbs_{song}={t}}}] run function mvpmusic:{song}/notes/{t}\n')
            return name
        mid = (lo + hi) // 2
        left = build_node(lo, mid)
        right = build_node(mid + 1, hi)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            if left:
                f.write(f'execute as @s[scores={{nbs_{song}=..{mid}}}] run function mvpmusic:{song}/tree/{left}\n')
            if right:
                f.write(f'execute as @s[scores={{nbs_{song}={mid + 1}..}}] run function mvpmusic:{song}/tree/{right}\n')
        return name

    root_name = build_node(0, maxtick)

    def w(path, text):
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(text)

    w(os.path.join(root, 'load.mcfunction'),
      f'scoreboard objectives add nbs_{song} dummy\n'
      f'scoreboard objectives add nbs_{song}_t dummy\n'
      f'scoreboard players set speed nbs_{song} 1\n')
    w(os.path.join(root, 'play.mcfunction'),
      f'tag @s add nbs_{song}\n'
      f'scoreboard players set @s nbs_{song} 0\n')
    w(os.path.join(root, 'stop.mcfunction'),
      f'tag @s remove nbs_{song}\n'
      f'scoreboard players reset @s nbs_{song}\n'
      f'scoreboard players reset @s nbs_{song}_t\n')
    w(os.path.join(root, 'pause.mcfunction'), f'tag @s remove nbs_{song}\n')
    w(os.path.join(root, 'uninstall.mcfunction'),
      f'tag @e remove nbs_{song}\n'
      f'scoreboard objectives remove nbs_{song}\n'
      f'scoreboard objectives remove nbs_{song}_t\n')
    w(os.path.join(root, 'tick.mcfunction'),
      f'execute as @a[tag=nbs_{song}] run scoreboard players add @s nbs_{song} 1\n'
      f'execute as @a[tag=nbs_{song},scores={{nbs_{song}={maxtick + 1}..}}] run function mvpmusic:{song}/stop\n'
      f'execute as @a[tag=nbs_{song}] at @s run function mvpmusic:{song}/tree/{root_name}\n')
    return maxtick, len(events)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--midi', required=True)
    ap.add_argument('--song', required=True)
    ap.add_argument('--start', type=float, required=True)
    ap.add_argument('--end', type=float, required=True)
    ap.add_argument('--out', required=True)
    a = ap.parse_args()
    events, bpm = build(a.midi, a.start, a.end, a.song)
    maxtick, nt = emit(events, a.song, a.out)
    print(f'bpm={bpm} events(tick)={nt} notes={sum(len(v) for v in events.values())} last_tick={maxtick} '
          f'duration={maxtick / 20.0:.1f}s')


if __name__ == '__main__':
    main()
