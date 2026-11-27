import io

def rd(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()

def wr(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

# 书的说明注释
p = r"src/data/kitpvp/functions/skill/enchanter/book_hold.mcfunction"
s = rd(p)
s = s.replace(
    "# 主手拿着《神学大全》：减速 30% + 闪烁发光 + 音效与粒子 + 两条进度合计 40 秒涨 1 级（满级就停）",
    "# 主手拿着《神学大全》：减速 30% + 闪烁发光 + 音效与粒子（右键方块展开坐杀博徒，蓄力全靠领域抽卡）")
wr(p, s)

# 职业卡
p = r"src/data/kitpvp/functions/kit/info/enchanter.mcfunction"
s = rd(p)
s = s.replace(
    '{"text":"打人涨剑、挨打涨甲，靠附魔追平战士","color":"white"}',
    '{"text":"常态不能蓄力；右键方块展开赌场，20 秒内每次命中抽一张卡","color":"white"}')
s = s.replace(
    '{"text":"用剑打中玩家 → 剑附魔蓄力 +1；被玩家打中 → 护甲附魔蓄力 +1（各 3 点升 1 级，各 11 级封顶）","color":"white"}',
    '{"text":"常态不涨进度；只有「坐杀博徒」领域里，打人抽剑卡、被打涨护甲进度（3 点升 1 级，各 11 级封顶）","color":"white"}')
s = s.replace(
    '{"text":"《神学大全》","color":"gold"},{"text":"（主手）：移速 -30%、发光每 2 秒闪一次、两条蓄力各按 40 秒升 1 级","color":"white"}',
    '{"text":"《神学大全》","color":"gold"},{"text":"（主手）：移速 -30%、每 2 秒闪一次；右键方块展开「坐杀博徒」","color":"white"}')
s = s.replace(
    '{"text":"无（全靠被动成长）","color":"white"}',
    '{"text":"坐杀博徒：右键方块展开 20 秒赌场，冷却 50 秒；普通 70% / 稀有 25% / 传说 5%","color":"white"}')
wr(p, s)

# 选职业时的提示与书 Lore
p = r"src/data/kitpvp/functions/kit/enchanter.mcfunction"
s = rd(p)
s = s.replace(
    """Lore:['{"text":"拿在主手：移速 -30%、身上发光","color":"gray","italic":false}','{"text":"拿满 40 秒，剑和护甲各升 1 级","color":"dark_gray","italic":false}']""",
    """Lore:['{"text":"拿在主手：移速 -30%、身上闪烁发光","color":"gray","italic":false}','{"text":"右键方块：展开「坐杀博徒」，20 秒内每次命中抽卡","color":"dark_gray","italic":false}','{"text":"常态不能蓄力——赌场之外不会有任何进度","color":"dark_gray","italic":false}']""")
s = s.replace(
    '{"text":"打中人 → 剑附魔充能；被打中 → 护甲附魔充能（各 3 点升 1 级）","color":"dark_gray"}',
    '{"text":"常态不能蓄力；右键方块展开「坐杀博徒」，20 秒内每次命中抽一张卡","color":"dark_gray"}')
s = s.replace(
    '{"text":"《神学大全》拿在主手：移速 -30%、发光闪烁，40 秒给两条各升 1 级","color":"dark_gray"}',
    '{"text":"《神学大全》拿在主手：移速 -30%、闪烁发光；右键方块开场，冷却 50 秒","color":"dark_gray"}')
wr(p, s)
print("text updated")
