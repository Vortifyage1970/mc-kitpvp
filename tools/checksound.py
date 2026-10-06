import mido
from collections import defaultdict
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

m = mido.MidiFile(r"D:\mc-kitpvp\tools\Voyage1969.mid")
by_ch = defaultdict(list)
for tr in m.tracks:
    for msg in tr:
        if msg.type == "note_on" and msg.velocity > 0:
            by_ch[msg.channel].append(msg.note)

for ch in sorted(by_ch):
    ns = sorted(by_ch[ch])
    mid = ns[len(ns)//2]
    lo, hi = ns[0], ns[-1]
    span = hi - lo
    print(f"ch{ch:2d}  n={len(ns):4d}  范围 {lo}~{hi}  跨度 {span} 半音  中位 {mid}  八度折叠={max(0, span-24)} 半音")