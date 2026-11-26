import sys
sys.path.insert(0, 'tools')
from midi2nbs import build
from collections import Counter

ev, bpm = build(r"C:\Users\33990\Desktop\花上亡灵 final 教学版.mid", 116, 157.4, 'huashang')
counts = sorted(((len(v), t) for t, v in ev.items()), reverse=True)[:8]
print('max notes per tick:', counts)
print('ticks:', len(ev), 'total notes:', sum(len(v) for v in ev.values()))
print('instruments:', Counter(i for v in ev.values() for i, _, _ in v))
