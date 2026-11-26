import random
from collections import Counter
p = 45/128
N = 400000
# 无保底
c = Counter()
for _ in range(N):
    c['sharp' if random.random() < p else 'other'] += 1
print('无保底 锋利 =', round(c['sharp']/N*100, 2), '%')

# 有保底（连续 3 次没锋利，第 4 次强制锋利）
cnt = Counter(); pity = 0
for _ in range(N):
    if pity >= 3:
        k = 'sharp'
    else:
        k = 'sharp' if random.random() < p else 'other'
    cnt[k] += 1
    pity = 0 if k == 'sharp' else pity + 1
print('有保底 锋利 =', round(cnt['sharp']/N*100, 2), '%   非锋利 =', round(cnt['other']/N*100, 2), '%')

# 每类
w = {'sharp': 45, 'fire': 19, 'kb': 38, 'smite': 26}
cnt = Counter(); pity = 0
for _ in range(N):
    if pity >= 3:
        k = 'sharp'
    else:
        r = random.randrange(128)
        k = 'sharp' if r < 45 else 'fire' if r < 64 else 'kb' if r < 102 else 'smite'
    cnt[k] += 1
    pity = 0 if k == 'sharp' else pity + 1
print('有保底各类实际占比：', {k: round(v/N*100, 2) for k, v in cnt.items()})
print('11 次期望：', {k: round(v/N*11, 2) for k, v in cnt.items()})