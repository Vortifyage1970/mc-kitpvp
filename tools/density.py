import sys
sys.path.insert(0, "tools")
from midi_info import parse

path = r"C:\Users\33990\Desktop\花上亡灵 final 教学版.mid"
fmt, div, tracks = parse(path)
tempos = sorted([(t, b) for tr in tracks for (k, t, b) in tr["metas"] if k == "tempo"])
bpm = tempos[0][1] if tempos else 120.0
def secs(tick):
    return tick / div * (60.0 / bpm)
rows = [(secs(x[0]), x[4], x[1]) for tr in tracks for x in tr["notes"] if x[1] == "on"]
maxs = max(r[0] for r in rows)
print("duration %.1fs" % maxs)
buckets = {}
for s, ch, kind in rows:
    b = int(s)
    buckets[b] = buckets.get(b, 0) + 1
for b in range(100, min(200, int(maxs)+1)):
    n = buckets.get(b, 0)
    print(f"{b:3d}s {n:3d} " + "#" * min(60, n))
