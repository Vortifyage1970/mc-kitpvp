import io, os, re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s, encoding='utf-8'):
    with io.open(p, 'w', encoding=encoding, newline='\n') as f:
        f.write(s)


# 1) 大厅里不该蓄力：加 #state == 1
p = os.path.join(FN, 'tick', 'earth.mcfunction')
t = read(p)
old = 'execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=98,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/enchanter/tick'
new = 'execute if score #state kitpvp.game matches 1 as @a[tag=kitpvp.selected,scores={kitpvp.kit=98,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/enchanter/tick'
assert old in t
write(p, t.replace(old, new))

# 2) 版本号
p = os.path.join(ROOT, 'src', 'pack.mcmeta')
t = read(p)
t = re.sub(r'"description": "[^"]*"', '"description": "KitPvP · 职业战争 · 地球生灵 75 · v1.1.0 (2026-11-26)"', t)
write(p, t)

p = os.path.join(FN, 'debug', 'version.mcfunction')
t = read(p)
t = t.replace('{"text":"v1.0.0","color":"white"}', '{"text":"v1.1.0","color":"white"}')
t = t.replace('（地球生灵 75 只，2026-11-14 构建）', '（地球生灵 75 只，2026-11-26 构建）')
write(p, t)

p = os.path.join(FN, 'load.mcfunction')
t = read(p)
t = t.replace('say Kitpvp loaded', 'say Kitpvp loaded · v1.1.0')
write(p, t)

print('ok')
