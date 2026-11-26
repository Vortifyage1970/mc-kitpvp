"""附魔师成长曲线蒙特卡洛（修正版）

战士基准（kit/warrior.mcfunction）：铁套 15 甲、铁剑 6 伤、攻速 1.6、20 血
  1.20.1 护甲公式：实伤 = dmg * (1 - min(20, max(甲/5, 甲 - dmg/2)) / 25)
  -> 战士打满铁套：6 点 -> 3.12；挨 6 点 -> 3.12（对等）
附魔师：金套 11 甲、金剑 4 伤、20 血
  -> 挨 6 点 = 4.08；打满铁套 4 点 = 1.92（低伤害被护甲吃得特别狠）

追平判定 = 输出 >= 3.12 且 承伤 <= 3.12
"""
import random, statistics

WARRIOR_OUT = 3.12
WARRIOR_TAKEN = 3.12

def armor_after(dmg, armor):
    red = min(20.0, max(armor / 5.0, armor - dmg / 2.0)) / 25.0
    return dmg * (1 - red)

def sharp_bonus(level):
    return 0.0 if level <= 0 else 1.0 + 0.5 * (level - 1)

SWORD_W = {"sharp": 0.55, "fire": 0.15, "kb": 0.20, "smite": 0.10}
SWORD_CAP = {"sharp": 5, "fire": 2, "kb": 2, "smite": 5}
ARMOR_W = [
    {"prot": 0.40, "proj": 0.20, "fire": 0.20, "blast": 0.20},
    {"prot": 0.40, "proj": 0.15, "thorns": 0.15, "fire": 0.15, "blast": 0.15},
    {"prot": 0.40, "proj": 0.15, "thorns": 0.15, "fire": 0.15, "blast": 0.15},
    {"prot": 0.35, "proj": 0.15, "fall": 0.15, "fire": 0.15, "blast": 0.20},
]

def draw(weights, caps, cur):
    pool = [(k, w) for k, w in weights.items() if cur.get(k, 0) < caps.get(k, 99)]
    if not pool:
        return None
    tot = sum(w for _, w in pool)
    r = random.random() * tot
    acc = 0.0
    for k, w in pool:
        acc += w
        if r <= acc:
            return k
    return pool[-1][0]

def run(t_sec, total_sec=300, prot_cap=2, pity=3, cap_sharp=5):
    sword = {"sharp": 0, "fire": 0, "kb": 0, "smite": 0}
    armor = [{"prot": 0, "proj": 0, "fire": 0, "blast": 0, "thorns": 0, "fall": 0} for _ in range(4)]
    miss, elapsed = 0, 0.0
    while elapsed + 1e-9 < total_sec:
        elapsed += t_sec
        if elapsed > total_sec + 1e-9:
            break
        if miss >= pity and sword["sharp"] < cap_sharp:
            k = "sharp"
        else:
            caps = dict(SWORD_CAP); caps["sharp"] = cap_sharp
            k = draw(SWORD_W, caps, sword)
        if k == "sharp":
            sword["sharp"] = min(cap_sharp, sword["sharp"] + 1); miss = 0
        elif k is not None:
            sword[k] += 1; miss += 1
        for i in range(4):
            caps = {"prot": prot_cap, "proj": 2, "fire": 2, "blast": 2, "thorns": 2, "fall": 2}
            k = draw(ARMOR_W[i], caps, armor[i])
            if k is not None:
                armor[i][k] += 1
    dmg = 4.0 + sharp_bonus(sword["sharp"])
    out = armor_after(dmg, 15)
    epf = min(20, sum(a["prot"] for a in armor))
    taken = armor_after(6.0, 11) * (1 - 0.04 * epf)
    return out, taken, (out >= WARRIOR_OUT - 1e-9 and taken <= WARRIOR_TAKEN + 1e-9), sword["sharp"], epf

def stats(t_sec, n=40000, **kw):
    outs, takens, ok = [], [], 0
    for _ in range(n):
        o, d, good, s, e = run(t_sec, **kw)
        outs.append(o); takens.append(d); ok += good
    return statistics.mean(outs), statistics.mean(takens), ok / n

print("=== 5 分钟：数值追平战士的概率（保护上限 2/件、保底 3 次）===")
for t in (20, 25, 30, 35, 40, 45, 50, 60):
    o, d, p = stats(t)
    print(f"t={t:>3}s  输出均值 {o:.2f}（战士 {WARRIOR_OUT}）  承伤均值 {d:.2f}（战士 {WARRIOR_TAKEN}）  追平概率 {p*100:5.1f}%")

print()
print("=== 8 分钟封顶后的面板（保护上限 2/件）===")
for t in (30, 35, 40, 45):
    o, d, p = stats(t, 40000, total_sec=480)
    print(f"t={t:>3}s  输出 {o:.2f}（{(o/WARRIOR_OUT-1)*100:+.0f}%）  承伤 {d:.2f}（比战士硬 {(WARRIOR_TAKEN/d-1)*100:+.0f}%）")
