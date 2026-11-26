import sys, struct
from collections import Counter

def read_vlq(b, i):
    v = 0
    while True:
        c = b[i]; i += 1
        v = (v << 7) | (c & 0x7F)
        if not (c & 0x80):
            return v, i

def parse(path):
    data = open(path, 'rb').read()
    assert data[:4] == b'MThd', 'not a midi'
    hlen = struct.unpack('>I', data[4:8])[0]
    fmt, ntrk, div = struct.unpack('>HHH', data[8:14])
    if div & 0x8000:
        raise SystemExit('SMPTE division not supported')
    print(f'format={fmt} tracks={ntrk} division={div} ticks/quarter')
    pos = 8 + hlen
    tracks = []
    for t in range(ntrk):
        assert data[pos:pos+4] == b'MTrk', data[pos:pos+4]
        tlen = struct.unpack('>I', data[pos+4:pos+8])[0]
        body = data[pos+8:pos+8+tlen]
        pos += 8 + tlen
        i = 0; tick = 0; status = None; name = ''
        notes = []       # (tick, kind, note, vel, ch)
        metas = []
        progs = {}
        while i < len(body):
            dt, i = read_vlq(body, i)
            tick += dt
            if i >= len(body): break
            c = body[i]
            if c < 0x80:
                c = status
            else:
                i += 1
                if c < 0xF0: status = c
            if c == 0xFF:
                mtype = body[i]; i += 1
                ln, i = read_vlq(body, i)
                payload = body[i:i+ln]; i += ln
                if mtype == 0x03: name = payload.decode('utf-8', 'replace')
                if mtype == 0x51:
                    us = int.from_bytes(payload, 'big')
                    metas.append(('tempo', tick, 60_000_000 / us))
                if mtype == 0x58:
                    metas.append(('timesig', tick, tuple(payload)))
                if mtype == 0x59:
                    metas.append(('keysig', tick, tuple(payload)))
                if mtype == 0x2F: break
            elif c in (0xF0, 0xF7):
                ln, i = read_vlq(body, i); i += ln
            else:
                hi = c & 0xF0; ch = c & 0x0F
                if hi in (0xC0, 0xD0):
                    d = body[i]; i += 1
                    if hi == 0xC0: progs[ch] = d
                else:
                    a = body[i]; b2 = body[i+1]; i += 2
                    if hi == 0x90 and b2 > 0: notes.append((tick, 'on', a, b2, ch))
                    elif hi == 0x80 or (hi == 0x90 and b2 == 0): notes.append((tick, 'off', a, b2, ch))
        tracks.append(dict(name=name, notes=notes, metas=metas, progs=progs))
    return fmt, div, tracks

def main(path):
    fmt, div, tracks = parse(path)
    tempos = [(t, bpm) for tr in tracks for (k, t, bpm) in tr['metas'] if k == 'tempo']
    tempos.sort()
    print('tempo events:', [(round(pt/div, 2), round(bpm, 2)) for pt, bpm in tempos][:12], '...' if len(tempos) > 12 else '')
    tss = [(t, ts) for tr in tracks for (k, t, ts) in tr['metas'] if k == 'timesig']
    print('time signatures:', [(round(pt/div, 2), ts[0], ts[1]) for pt, ts in sorted(tss)][:8])
    maxtick = 0
    for n, tr in enumerate(tracks):
        on = [x for x in tr['notes'] if x[1] == 'on']
        if not on and not tr['name']:
            print(f'  track {n}: empty')
            continue
        ticks = [x[0] for x in tr['notes']]
        if ticks: maxtick = max(maxtick, max(ticks))
        print(f'  track {n}: name={tr["name"]!r} notes={len(on)} chans={sorted(Counter(x[4] for x in on))} '
              f'progs={tr["progs"]} pitch={min((x[2] for x in on), default=0)}..{max((x[2] for x in on), default=0)}')
    # tempo map -> seconds
    def secs(tick):
        t = 0.0; cur_tick = 0; bpm = 120.0
        for pt, b in tempos or [(0, 120.0)]:
            if pt > tick: break
            t += (pt - cur_tick) / div * (60.0 / bpm)
            cur_tick = pt; bpm = b
        t += (tick - cur_tick) / div * (60.0 / bpm)
        return t
    print(f'total ticks={maxtick}  approx {secs(maxtick):.1f}s at last tempo map')
    total_on = sum(len([x for x in tr['notes'] if x[1] == 'on']) for tr in tracks)
    print('total note-ons =', total_on)

if __name__ == '__main__':
    main(sys.argv[1])
