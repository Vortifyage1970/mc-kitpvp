import mido
import mido.midifiles.meta as _mido_meta
import mido.midifiles.midifiles as _mido_mf
from collections import defaultdict

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

m = mido.MidiFile(r"D:\mc-kitpvp\tools\Voyage1969.mid")
print(f"type={m.type}  ticks_per_beat={m.ticks_per_beat}  tracks={len(m.tracks)}")

for i, track in enumerate(m.tracks):
    channels = defaultdict(int)
    programs = defaultdict(set)
    notes = []
    for msg in track:
        if msg.type == "note_on" and msg.velocity > 0:
            channels[msg.channel] += 1
            notes.append(msg.note)
        if msg.type == "program_change":
            programs[msg.channel].add(msg.program)
    print(f"\nTrack {i}: name={track.name!r}")
    print(f"  通道音符数: {dict(channels)}")
    print(f"  program_change: {dict(programs)}")
    if notes:
        print(f"  音高范围: {min(notes)} ~ {max(notes)}")