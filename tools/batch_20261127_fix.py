# -*- coding: utf-8 -*-
"""一次性改造：踢掉铁人 / 大蜜蜂；修篝火；动员家只在召唤与死亡时发动准备。"""
import io, os, re, sys

FUNC = r"src/data/kitpvp/functions"
gone_tags = ["kitpvp.earth_bigbee", "kitpvp.earth_ironman"]


def read(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()


def write(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)


# ---------- 1. 随机池：删掉两行并重新编号 ----------
rp = os.path.join(FUNC, "skill/earth/random.mcfunction")
lines = read(rp).split("\n")
out = []
for ln in lines:
    if "summon/earth_bigbee" in ln or "summon/earth_ironman" in ln:
        continue
    out.append(ln)

pat = re.compile(r"(matches\s+)(\d+)( run function kitpvp:summon/)")
idx = 0
fixed = []
for ln in out:
    m = pat.search(ln)
    if m:
        ln = pat.sub(lambda _m: "%s%d%s" % (_m.group(1), idx, _m.group(3)), ln, count=1)
        idx += 1
    fixed.append(ln)
text = "\n".join(fixed)
text = re.sub(r"#pool_size kitpvp\.game \d+", "#pool_size kitpvp.game %d" % idx, text)
write(rp, text)
print("pool entries:", idx)

# ---------- 2. 删文件 ----------
for rel in [
    "summon/earth_bigbee.mcfunction", "skill/earth/bigbee_aura.mcfunction",
    "summon/earth_ironman.mcfunction", "skill/earth/ironman_tick.mcfunction",
    "skill/earth/ironman_bomb.mcfunction",
    "debug/ironman_force.mcfunction", "debug/ironman_probe.mcfunction",
]:
    p = os.path.join(FUNC, rel)
    if os.path.exists(p):
        os.remove(p)
        print("removed", rel)

# ---------- 3. tick/earth：删调用与递减 ----------
tp = os.path.join(FUNC, "tick/earth.mcfunction")
tl = read(tp).split("\n")
keep = []
for ln in tl:
    if "kitpvp.earth_bigbee" in ln or "kitpvp.earth_ironman" in ln or "bee_slow_snd" in ln:
        continue
    keep.append(ln)
write(tp, "\n".join(keep))
print("tick/earth lines:", len(keep))

# ---------- 4. load：删两个 objective ----------
lp = os.path.join(FUNC, "load.mcfunction")
ll = read(lp).split("\n")
keep = [ln for ln in ll if "kitpvp.bee_slow_snd" not in ln and "kitpvp.im_cd" not in ln]
write(lp, "\n".join(keep))
print("load lines:", len(keep))

# ---------- 5. reset_entities ----------
ep = os.path.join(FUNC, "game/reset_entities.mcfunction")
el = read(ep).split("\n")
keep = []
for ln in el:
    if "kitpvp.earth_bigbee" in ln or "kitpvp.earth_ironman" in ln:
        continue
    keep.append(ln.replace(", earth_bigbee", "").replace(", earth_ironman", ""))
write(ep, "\n".join(keep))

# ---------- 6. selfcheck ----------
sp = os.path.join(FUNC, "debug/selfcheck.mcfunction")
if os.path.exists(sp):
    sl = read(sp).split("\n")
    keep = [ln for ln in sl if "kitpvp.earth_bigbee" not in ln]
    write(sp, "\n".join(keep))

# ---------- 7. 篝火：补 revoke（之前没人撤销，每局只触发一次） ----------
cp = os.path.join(FUNC, "skill/earth/campfire_touch.mcfunction")
cl = read(cp).split("\n")
if not any("advancement revoke" in ln for ln in cl):
    ins = 0
    for i, ln in enumerate(cl):
        if ln.startswith("#"):
            ins = i + 1
        else:
            break
    cl.insert(ins, "advancement revoke @s only kitpvp:player/campfire_touch")
    write(cp, "\n".join(cl))
    print("campfire_touch: revoke added")

# ---------- 8. 动员家：只在召唤时发一次，之后不再循环 ----------
mp = os.path.join(FUNC, "skill/earth/mobilizer_prompt.mcfunction")
ml = read(mp).split("\n")
new = []
for ln in ml:
    if ln.startswith("scoreboard players set @s kitpvp.earth_cd_a 400"):
        new.append("# 只发动一次：设成极大值，这辈子不会再到期（需求：只在被召唤与死亡时发动「准备」）")
        new.append("scoreboard players set @s kitpvp.earth_cd_a 1000000")
    else:
        new.append(ln)
write(mp, "\n".join(new))

sp2 = os.path.join(FUNC, "summon/earth_mobilizer.mcfunction")
s2 = read(sp2)
s2 = s2.replace(
    "scoreboard players set @e[tag=kitpvp.earth_mobilizer] kitpvp.earth_cd_a 400",
    "scoreboard players set @e[tag=kitpvp.earth_mobilizer] kitpvp.earth_cd_a 20")
s2 = s2.replace(
    "只要它活着，每 15 秒逼全场点一次\"准备\"",
    "只在出场与死亡时各发动一次「准备」")
s2 = s2.replace(
    "计时挂在 earth_cd_a 上（400 刻 = 20 秒），归零时 tick 调 mobilizer_prompt 发提示并排 5 秒后的结算",
    "计时挂在 earth_cd_a 上：出场 1 秒后（20 刻）调 mobilizer_prompt 发动一次，之后 prompt 把它设成极大值，不再循环")
write(sp2, s2)
print("mobilizer summon: cd 400 -> 20")

print("done")
