# advancement：附魔师打中玩家。常态完全不能蓄力，只有坐杀博徒领域里才抽卡
advancement revoke @s only kitpvp:player/ench_hit
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/enchanter/domain_draw
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 unless entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"常态不能蓄力：用「坐杀博徒·入场券」开赌场","color":"gray"}
