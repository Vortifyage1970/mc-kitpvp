import io, os, subprocess

REV = "992fd819"
SRC = "src/data/kitpvp/functions/skill/enchanter/"
DST = "src/data/kitpvp/functions/skill/li_ench/"

MAP = {
    "domain_cast": "cast",
    "domain_start": "start",
    "domain_tick": "tick_domain",
    "domain_end": "end",
    "domain_draw": "draw",
    "tmp_expire": "tmp_expire",
    "egg_cast": "redraw",
    "hud": "hud",
    "hud_show": "hud_show",
    "hud_calc": "hud_calc",
    "assign_slot": "assign_slot",
    "name_refresh": "name_refresh",
}

def git_show(path):
    out = subprocess.run(["git", "show", REV + ":" + path], capture_output=True)
    if out.returncode != 0:
        raise SystemExit("missing " + path)
    return out.stdout.decode("utf-8")

def write(rel, s):
    p = os.path.join(DST, rel)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

for src, dst in MAP.items():
    s = git_show(SRC + src + ".mcfunction")
    s = s.replace("kitpvp:skill/enchanter/", "kitpvp:skill/li_ench/")
    s = s.replace("kitpvp.kit matches 15", "kitpvp.kit matches 99")
    write(dst + ".mcfunction", s)

# 卡牌：名字保持 cXX
cards = subprocess.run(["git", "ls-tree", "--name-only", REV, SRC + "card/"], capture_output=True).stdout.decode().split()
for path in cards:
    if not path.endswith(".mcfunction"):
        continue
    name = path.split("/")[-1]
    s = git_show(path)
    s = s.replace("kitpvp:skill/enchanter/", "kitpvp:skill/li_ench/")
    write("card/" + name, s)

print("ported", len(cards), "cards")
