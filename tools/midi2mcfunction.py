#!/usr/bin/env python3
"""
midi2mcfunction
把 MIDI 转成 Minecraft 1.20.1 数据包可用的 mcfunction（playsound 序列）。

依赖: pip install mido
用法:
    python midi2mcfunction.py <input.mid> <out_data_dir> [--name 名字] [--sound 音效]
例:
    python midi2mcfunction.py song.mid ./src/data --name my_song
"""

import argparse
import re
from collections import defaultdict
from pathlib import Path

import mido

TICKS_PER_SECOND = 20
MIN_PITCH = 0.5
MAX_PITCH = 2.0
MIN_VOLUME = 0.1
MAX_VOLUME = 1.0


def sanitize_name(s):
    s = s.lower()
    s = re.sub(r"[^a-z0-9_-]", "_", s)
    s = re.sub(r"_+", "_", s).strip("_")
    return s or "song"


def parse_midi(path):
    """读 MIDI，返回 [(start_sec, dur_sec, note, velocity)]。"""
    mid = mido.MidiFile(path)
    ticks_per_beat = mid.ticks_per_beat

    # 1) 显式合并所有轨道，记录 (绝对tick, msg)
    abs_events = []
    for track in mid.tracks:
        t = 0
        for msg in track:
            t += msg.time
            abs_events.append((t, msg))
    # 稳定排序：同一 tick 的事件保留原顺序
    abs_events.sort(key=lambda x: x[0])

    notes = []
    # note -> [(start_sec, velocity), ...]  用 list 防止同音重叠被覆盖
    active = defaultdict(list)
    current_sec = 0.0
    last_tick = 0
    tempo = 500000  # 默认 120 BPM

    for tick, msg in abs_events:
        # 按“上一事件 -> 当前事件”的 tick 差和当前 tempo 推进时间
        current_sec += mido.tick2second(tick - last_tick, ticks_per_beat, tempo)
        last_tick = tick

        if msg.type == "set_tempo":
            tempo = msg.tempo
        elif msg.type == "note_on" and msg.velocity > 0:
            active[msg.note].append((current_sec, msg.velocity))
        elif msg.type == "note_off" or (msg.type == "note_on" and msg.velocity == 0):
            stack = active.get(msg.note)
            if stack:
                start, vel = stack.pop(0)
                notes.append((start, current_sec - start, msg.note, vel))

    # 兜底：没配对的 note_on
    for note, stack in active.items():
        for start, vel in stack:
            notes.append((start, current_sec - start, note, vel))

    return notes


def build_events(notes):
    """按 tick 分组，返回升序的 [(tick, [(note, velocity), ...])]。"""
    buckets = defaultdict(list)
    for start_sec, _dur, note, vel in notes:
        tick = int(round(start_sec * TICKS_PER_SECOND))
        buckets[tick].append((note, vel))
    return sorted(buckets.items(), key=lambda kv: kv[0])


def pick_anchor(notes):
    """挑移调锚点：让音高尽量落在 [0.5, 2.0] 区间。"""
    if not notes:
        return 60
    pitches = sorted(m[2] for m in notes)
    return pitches[len(pitches) // 2]


def midi_to_pitch(note, anchor):
    p = 2.0 ** ((note - anchor) / 12.0)
    return max(MIN_PITCH, min(MAX_PITCH, p))


def vel_to_volume(vel):
    if vel <= 0:
        return MIN_VOLUME
    if vel >= 127:
        return MAX_VOLUME
    return MIN_VOLUME + (MAX_VOLUME - MIN_VOLUME) * (vel / 127.0)


def fmt(x):
    s = f"{x:.4f}".rstrip("0").rstrip(".")
    return s if s else "0"


def write_file(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def build(midi_path, out_dir, song, sound, ns):
    notes = parse_midi(midi_path)
    if not notes:
        raise SystemExit("这个 MIDI 里没有音符。")

    anchor = pick_anchor(notes)
    events = build_events(notes)
    total = len(events)

    base = Path(out_dir) / ns / "functions" / "music" / song
    base.mkdir(parents=True, exist_ok=True)

    for i, (tick, group) in enumerate(events):
        lines = [f"# tick {tick} | 音符 {len(group)}"]

        for note, vel in group:
            pitch = fmt(midi_to_pitch(note, anchor))
            volume = fmt(vel_to_volume(vel))
            lines.append(
    f"execute as @a at @s run playsound {sound} master @s ~ ~ ~ {volume} {pitch}"
)

        if i + 1 < total:
            next_tick = events[i + 1][0]
            delay = max(next_tick - tick, 1)
            next_name = f"ev_{i + 1:04d}"
            lines.append(
                f"schedule function {ns}:music/{song}/{next_name} {delay}t replace"
            )

        write_file(base / f"ev_{i:04d}.mcfunction", "\n".join(lines) + "\n")

    first_tick = events[0][0]
    start_lines = [
        f"# 播放: {song}（{total} 个事件 tick，共 {len(notes)} 个音符）",
        f"schedule function {ns}:music/{song}/ev_0000 {max(first_tick, 1)}t replace",
        f'tellraw @a {{"text":"[音乐] {song}","color":"aqua"}}',
    ]
    write_file(base / "start.mcfunction", "\n".join(start_lines) + "\n")

    return len(notes), total, anchor


def main():
    ap = argparse.ArgumentParser(description="MIDI → 1.20.1 playsound mcfunction")
    ap.add_argument("midi", help="输入 MIDI 文件")
    ap.add_argument("out", help="数据包 data 目录（例如 ./src/data）")
    ap.add_argument("--name", default=None, help="歌曲名，默认取文件名")
    ap.add_argument("--sound", default="minecraft:block.note_block.harp",
                    help="音效 id，默认 harp")
    ap.add_argument("--namespace", default="kitpvp", help="命名空间，默认 kitpvp")
    args = ap.parse_args()

    song = sanitize_name(args.name or Path(args.midi).stem)
    n_notes, n_events, anchor = build(
        args.midi, args.out, song, args.sound, args.namespace
    )

    print(f"音符 {n_notes} 个 → 事件 tick {n_events} 个 | 移调锚点 MIDI={anchor}")
    print(f"输出目录: {Path(args.out) / args.namespace / 'functions' / 'music' / song}")
    print(f"播放:     /function {args.namespace}:music/{song}/start")


if __name__ == "__main__":
    main()
