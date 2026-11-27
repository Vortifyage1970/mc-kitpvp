import io
p = r"src/data/kitpvp/functions/skill/enchanter/domain_cast.mcfunction"
with io.open(p, encoding="utf-8") as f:
    s = f.read()
s = s.replace(
    'execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_cd matches ..0 run function kitpvp:skill/enchanter/domain_start',
    'execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches 1.. run function kitpvp:skill/enchanter/domain_start\n'
    'execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches ..0 run function kitpvp:skill/enchanter/domain_start')
s = s.replace(
    'execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_cd matches 1.. run title',
    'execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches 1.. run title')
with io.open(p, "w", encoding="utf-8", newline="\n") as f:
    f.write(s)
print(s)
