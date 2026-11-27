import io
p = r"src/data/kitpvp/functions/kit/info/enchanter.mcfunction"
with io.open(p, encoding="utf-8") as f:
    s = f.read()
s = s.replace('{"text":"坐杀博徒：右键方块展开 20 秒赌场，冷却 50 秒；普通 70% / 稀有 25% / 传说 5%","color":"white"}',
              '{"text":"坐杀博徒：右键「入场券」展开 60 秒赌场，冷却 60 秒；普通 70% / 稀有 25% / 传说 5%","color":"white"}')
s = s.replace('{"text":"：右键使用，展开 20 秒赌场（冷却 50 秒）","color":"white"}',
              '{"text":"：右键使用，展开 60 秒赌场（冷却 60 秒）","color":"white"}')
with io.open(p, "w", encoding="utf-8", newline="\n") as f:
    f.write(s)

p = r"src/data/kitpvp/functions/kit/enchanter.mcfunction"
with io.open(p, encoding="utf-8") as f:
    s = f.read()
s = s.replace('{"text":"《神学大全》拿在主手：移速 -30%、闪烁发光；右键方块开场，冷却 50 秒","color":"dark_gray"}',
              '{"text":"用「坐杀博徒·入场券」右键开场：60 秒赌场，冷却 60 秒","color":"dark_gray"}')
with io.open(p, "w", encoding="utf-8", newline="\n") as f:
    f.write(s)
print("texts ok")
