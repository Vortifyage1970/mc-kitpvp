import io, os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


AS = '''# 给附魔师分一条专属 bossbar 槽（1..8）
# 用玩家自己的 etid 取模：etid 每人唯一，所以两名附魔师不会抢同一条，
# 死亡重选、掉线重连也会自动算回同一条，不需要"找空位"那种会残留旧槽的写法。
scoreboard players operation @s kitpvp.ench_slot = @s kitpvp.etid
scoreboard players operation @s kitpvp.ench_slot %= #ench_eight kitpvp.game
scoreboard players operation @s kitpvp.ench_slot += #ench_one kitpvp.game
'''
write(os.path.join(FN, 'skill', 'enchanter', 'assign_slot.mcfunction'), AS)

p = os.path.join(FN, 'load.mcfunction')
t = read(p)
anchor = 'scoreboard objectives add kitpvp.ench_sslot dummy'
add = 'scoreboard players set #ench_eight kitpvp.game 8\nscoreboard players set #ench_one kitpvp.game 1\n'
assert anchor in t
if '#ench_eight' not in t:
    t = t.replace(anchor, add + anchor)
write(p, t)
print('ok')
