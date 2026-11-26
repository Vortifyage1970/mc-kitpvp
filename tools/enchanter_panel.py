"""附魔师理论面板（按当前代码的实际机制算）

实现对齐：
  kit/enchanter.mcfunction  金套 11 甲 / 金剑 4 伤 / 20 血 / 移速 0.1 / 攻速 1.6（金剑）
  skill/enchanter/upgrade  首发 15s，之后每 930 刻(46.5s) 一次，共 11 次，第 11 次在 480s
                           1..7 轮：剑 + 4 件护甲；8 头胸；9 腿靴；10 头腿；11 胸靴
  roll_sword               锋利 45 / 火焰 12 / 击退 22 / 横扫之刃 12 / 亡灵 37（/128）
                           连续 3 次没掷到锋利 -> 下一次强制锋利（ench_pity）
  roll_head/chest/legs     保护 26 / 弹射 26 / 第三项 25 / 火焰 25 / 爆炸 26（/128）
  roll_feet                保护 26 / 弹射 15 / 冰霜 15 / 火焰 15 / 爆炸 15 / 深海 14 / 摔落 14 / 灵魂疾行 14
  横扫之刃只在多目标时有用，1v1 不影响伤害，这里只统计次数
  无等级上限

护甲公式：实伤 = dmg * (1 - min(20, max(甲/5, 甲 - dmg/2)) / 25)
附魔保护：EPF 按伤害类型临时相加，减伤 = 4% * EPF（上限 80%），与护甲乘算
锋利：额外伤害 = 1 + 0.5*(级-1)；火焰附加：每级 4 秒，每秒 1 点、无视护甲
"""
import random, statistics

EVENTS = [(15.0 + 46.5 * i, i + 1) for i in range(11)]  # (秒, 轮次)


def armor_after(dmg, armor):
    red = min(20.0, max(armor / 5.0, armor - dmg / 2.0)) / 25.0
    return dmg * (1 - red)


def sharp_bonus(level):
    return 0.0 if level <= 0 else 1.0 + 0.5 * (level - 1)


SWORD = [(0, 44, 'sharp'), (45, 56, 'fire'), (57, 78, 'kb'), (79, 90, 'sweep'), (91, 127, 'smite')]
ARMOR3 = [(0, 25, 'prot'), (26, 51, 'proj'), (52, 76, 'junk'), (77, 101, 'fire'), (102, 127, 'blast')]
ARMOR_FEET = [(0, 25, 'prot'), (26, 40, 'proj'), (41, 55, 'junk'), (56, 70, 'fire'),
              (71, 85, 'blast'), (86, 99, 'junk'), (100, 113, 'fall'), (114, 127, 'junk')]


def pick(table, r):
    for lo, hi, name in table:
        if lo <= r <= hi:
            return name
    return table[-1][2]


def simulate(until):
    """跑到 until 秒为止的全部强化事件"""
    roll = 0
    pity = 0
    sw = {'sharp': 0, 'fire': 0, 'kb': 0, 'sweep': 0, 'smite': 0}
    arm = [{}, {}, {}, {}]  # 头 胸 腿 靴
    for t, n in EVENTS:
        if t > until + 1e-9:
            break
        # 剑
        r = 0 if pity >= 3 else random.randrange(128)
        k = pick(SWORD, r)
        sw[k] += 1
        pity = 0 if k == 'sharp' else pity + 1
        # 护甲
        if n <= 7:
            idx = [0, 1, 2, 3]
        elif n == 8:
            idx = [0, 1]
        elif n == 9:
            idx = [2, 3]
        elif n == 10:
            idx = [0, 2]
        else:
            idx = [1, 3]
        for i in idx:
            table = ARMOR_FEET if i == 3 else ARMOR3
            k = pick(table, random.randrange(128))
            arm[i][k] = arm[i].get(k, 0) + 1
    return sw, arm


def panel(seconds, n=60000):
    rows = []
    for _ in range(n):
        sw, arm = simulate(seconds)
        dmg = 4.0 + sharp_bonus(sw['sharp'])
        prot = sum(a.get('prot', 0) for a in arm)
        epf = min(20, prot)
        out = armor_after(dmg, 15)          # 打满铁套的战士
        taken = armor_after(6.0, 11) * (1 - 0.04 * epf)  # 挨铁剑 6 点
        rows.append((dmg, out, taken, prot, sw['fire'], sw['kb'], sw['sweep'], sw['smite'], sw['sharp']))
    avg = [statistics.mean(c) for c in zip(*rows)]
    return avg


def fmt(t, a):
    dmg, out, taken, prot, fire, kb, sweep, smite, sharp = a
    dps = out * 1.6
    ehp = 120.0 / taken          # 等效血量（按 6 点原始伤害折算）
    ttk = 20.0 / dps          # 打死 20 血战士（对方还没吃药）
    die = 20.0 / (taken * 1.6)  # 对方砍死你需要的秒数
    return (f"| {t} | {sharp:.2f} | {dmg:.2f} | {out:.2f} | {dps:.2f} | {prot:.1f} | "
            f"{taken:.2f} | {ehp:.1f} | {ttk:.1f} | {die:.1f} | 火焰 {fire:.2f} / 击退 {kb:.2f} / 横扫 {sweep:.2f} / 亡灵 {smite:.2f} |")


print('| 时间 | 锋利 | 剑伤 | 对铁套输出/下 | DPS | 保护EPF | 挨战士/下 | 等效血量 | 杀战士(秒) | 被杀(秒) | 其它附魔 |')
print('|---|---|---|---|---|---|---|---|---|---|---|')
for label, sec in (('0:00（开局）', 0), ('0:15（首发）', 15), ('1:00', 60), ('3:00', 180),
                   ('5:00', 300), ('8:00（封顶）', 480)):
    print(fmt(label, panel(sec)))

# 追平判定
for label, sec in (('5:00', 300), ('8:00', 480)):
    hits = 0
    N = 20000
    for _ in range(N):
        sw, arm = simulate(sec)
        dmg = 4.0 + sharp_bonus(sw['sharp'])
        prot = min(20, sum(a.get('prot', 0) for a in arm))
        if armor_after(dmg, 15) >= 3.12 and armor_after(6.0, 11) * (1 - 0.04 * prot) <= 3.12:
            hits += 1
    print(f'\n{label} 同时追平战士输出与承伤的概率：{hits / N * 100:.1f}%')
