import io, os, re, collections

LOG = r'E:\Games\mc启动器\PCL 正式版 2.10.3\.minecraft\versions\1.20.1-Forge_47.4.23\logs\latest.log'
with io.open(LOG, 'r', encoding='gbk', errors='replace') as f:
    lines = f.read().split('\n')

print('total', len(lines))

# locate "Failed to load function kitpvp:load" and print following exception lines
for i, ln in enumerate(lines):
    if 'Failed to load function kitpvp:load' in ln:
        print('---', ln.strip())
        for j in range(i + 1, min(i + 6, len(lines))):
            t = lines[j].strip()
            if t:
                print('   ', t[:300])
        break

# count failures per function
pat = re.compile(r'Failed to load function (\S+)')
cnt = collections.Counter()
for ln in lines:
    m = pat.search(ln)
    if m:
        cnt[m.group(1)] += 1
print('failing functions:', len(cnt))
for k, v in cnt.most_common(40):
    print('  ', k, v)

# distinct parse messages
pat2 = re.compile(r'Whilst parsing command on line (\d+): (.+)$')
msgs = collections.Counter()
for ln in lines:
    m = pat2.search(ln)
    if m:
        msgs[(m.group(1), m.group(2).strip()[:80])] += 1
print('parse messages:')
for k, v in msgs.most_common(10):
    print('  ', k, v)
