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
import mido.midifiles.meta as _mido_meta
import mido.midifiles.midifiles as _mido_mf

# GM 乐器号 → Minecraft 音效
GM_TO_MC = {}
for i in range(0, 8):      GM_TO_MC[i] = "minecraft:block.note_block.harp"       # 钢琴
for i in range(8, 16):     GM_TO_MC[i] = "minecraft:block.note_block.bell"       # 色彩打击
for i in range(16, 24):    GM_TO_MC[i] = "minecraft:block.note_block.bell"       # 风琴
for i in range(24, 32):    GM_TO_MC[i] = "minecraft:block.note_block.guitar"     # 吉他
for i in range(32, 40):    GM_TO_MC[i] = "minecraft:block.note_block.bass"       # 贝斯
for i in range(40, 48):    GM_TO_MC[i] = "minecraft:block.note_block.harp"       # 弦乐
for i in range(48, 56):    GM_TO_MC[i] = "minecraft:block.note_block.bell"       # 合奏
for i in range(56, 64):    GM_TO_MC[i] = "minecraft:block.note_block.didgeridoo" # 铜管
for i in range(64, 72):    GM_TO_MC[i] = "minecraft:block.note_block.flute"      # 簧片
for i in range(72, 80):    GM_TO_MC[i] = "minecraft:block.note_block.flute"      # 管乐
for i in range(80, 88):    GM_TO_MC[i] = "minecraft:block.note_block.bit"        # 合成主音
for i in range(88, 96):    GM_TO_MC[i] = "minecraft:block.note_block.bit"        # 合成铺底
for i in range(96, 104):   GM_TO_MC[i] = "minecraft:block.note_block.bit"        # 合成效果
for i in range(104, 112):  GM_TO_MC[i] = "minecraft:block.note_block.banjo"      # 民族
for i in range(112, 120):  GM_TO_MC[i] = "minecraft:block.note_block.bell"       # 打击
for i in range(120, 128):  GM_TO_MC[i] = "minecraft:block.note_block.bit"        # 音效

# 通道 9 = GM 鼓组，按音高映射
DRUM_MAP = {
    35: "minecraft:block.note_block.basedrum",
    36: "minecraft:block.note_block.basedrum",
    38: "minecraft:block.note_block.snare",
    40: "minecraft:block.note_block.snare",
    42: "minecraft:block.note_block.hat",
    44: "minecraft:block.note_block.hat",
    46: "minecraft:block.note_block.hat",
    49: "minecraft:block.note_block.hat",   # crash
    51: "minecraft:block.note_block.hat",   # ride
    57: "minecraft:block.note_block.hat",   # crash 2
    59: "minecraft:block.note_block.hat",   # ride 2
}

def get_sound(channel, program, note, force_sound=None):
    if force_sound:
        return force_sound
    if channel == 9:
        return DRUM_MAP.get(note, "minecraft:block.note_block.basedrum")
    return GM_TO_MC.get(program, "minecraft:block.note_block.harp")

# --- 兼容补丁：跳过损坏的元事件（如长度为 0 的 key_signature）---
_orig_build_meta = _mido_meta.build_meta_message

def _safe_build_meta_message(meta_type, data, delta=0):
    try:
        return _orig_build_meta(meta_type, data, delta)
    except Exception:
        # 遇到解析不了的元事件就换成空的 text 事件，不中断读取
        return mido.MetaMessage('text', text='', time=delta)

_mido_meta.build_meta_message = _safe_build_meta_message
_mido_mf.build_meta_message = _safe_build_meta_message
# --- 补丁结束 ---

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
    """读 MIDI，返回 [(start_sec, dur_sec, note, velocity, channel, program)]。"""
    mid = mido.MidiFile(path)
    ticks_per_beat = mid.ticks_per_beat

    abs_events = []
    for track in mid.tracks:
        t = 0
        for msg in track:
            t += msg.time
            abs_events.append((t, msg))
    abs_events.sort(key=lambda x: x[0])

    notes = []
    active = defaultdict(list)          # key = (channel, note)
    current_sec = 0.0
    last_tick = 0
    tempo = 500000
    channel_program = {ch: 0 for ch in range(16)}

    for tick, msg in abs_events:
        current_sec += mido.tick2second(tick - last_tick, ticks_per_beat, tempo)
        last_tick = tick

        if msg.type == "set_tempo":
            tempo = msg.tempo
        elif msg.type == "program_change":
            channel_program[msg.channel] = msg.program
        elif msg.type == "note_on" and msg.velocity > 0:
            key = (msg.channel, msg.note)
            active[key].append(
                (current_sec, msg.velocity, msg.channel, channel_program[msg.channel])
            )
        elif msg.type == "note_off" or (msg.type == "note_on" and msg.velocity == 0):
            key = (msg.channel, msg.note)
            stack = active.get(key)
            if stack:
                start, vel, ch, prog = stack.pop(0)
                notes.append((start, current_sec - start, msg.note, vel, ch, prog))

    for (ch, note), stack in active.items():
        for start, vel, _ch, prog in stack:
            notes.append((start, current_sec - start, note, vel, ch, prog))

        # 过滤掉折叠严重 / 装饰性通道
    DROP_CHANNELS = {3, 7}
    notes = [n for n in notes if n[4] not in DROP_CHANNELS]
    return notes

    return notes


def build_events(notes, force_sound=None):
    buckets = defaultdict(list)
    for start_sec, _dur, note, vel, ch, prog in notes:
        tick = int(round(start_sec * TICKS_PER_SECOND))
        sound = get_sound(ch, prog, note, force_sound)
        buckets[tick].append((sound, note, vel, ch, ch == 9))
    for tick in buckets:
        buckets[tick].sort(key=lambda x: -x[2])
        buckets[tick] = buckets[tick][:6]
    return sorted(buckets.items(), key=lambda kv: kv[0])


def pick_anchor(notes):
    """按通道挑锚点，每个通道单独对齐 [0.5, 2.0]。"""
    by_ch = defaultdict(list)
    for start_sec, _dur, note, vel, ch, prog in notes:
        by_ch[ch].append(note)

    anchors = {}
    for ch, pitches in by_ch.items():
        if ch == 9:
            anchors[ch] = 60          # 鼓通道锚点无所谓，后面固定 pitch=1
        else:
            pitches.sort()
            anchors[ch] = pitches[len(pitches) // 2]
    return anchors


def midi_to_pitch(note, anchor):
    p = 2.0 ** ((note - anchor) / 12.0)
    if p < MIN_PITCH or p > MAX_PITCH:
        return None
    return p


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
    base = Path(out_dir) / ns / "functions" / "music" / song
    base.mkdir(parents=True, exist_ok=True)
    events = build_events(notes, force_sound=sound)
    total = len(events)

    for i, (tick, group) in enumerate(events):
        lines = [f"# tick {tick} | 音符 {len(group)}"]

        for snd, note, vel, ch, is_drum in group:
            if is_drum:
                # 鼓：音高固定 1，音量拉满
                lines.append(
                    f"execute as @a at @s run playsound {snd} master @s ~ ~ ~ 0.8 1"
                )
            else:
                # 每个通道用自己的锚点
                ch_anchor = anchor.get(ch, 60)
                pitch = midi_to_pitch(note, ch_anchor)
                if pitch is None:
                    continue
                volume = fmt(vel_to_volume(vel) * 0.7)
                lines.append(
                    f"execute as @a at @s run playsound {snd} master @s ~ ~ ~ {volume} {pitch}"
                )

        if i + 1 < total:
            next_tick = events[i + 1][0]
            delay = max(next_tick - tick, 1)
            next_name = f"ev_{i + 1:04d}"
            lines.append(
                f"schedule function {ns}:music/{song}/{next_name} {delay}t replace"
            )

        write_file(base / f"ev_{i:04d}.mcfunction", "\n".join(lines) + "\n")

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
    ap.add_argument("--sound", default=None,
                    help="强制使用某个音效；不指定则按 GM 乐器自动映射")
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
