# ===== 魂石使用入口（@s = 玩家）=====
# 由 tick 在 soul_dropped > soul_last 时调用。
# 首行必须是快照推进（铁律）：不推进，下一刻 dropped > last 仍成立，效果会每刻重放。
scoreboard players operation @s kitpvp.soul_last = @s kitpvp.soul_dropped

# 逐类型检测玩家附近的魂石掉落物。
# 用 at @s 定位到玩家当前位置；distance=..8 覆盖丢出物品自然飞行的距离。
# 顺序不能调：刺客会把自己传送走，它的判定必须排在最后，
# 保证前面三个判定仍然在玩家"原位置"完成。
execute at @s if entity @e[type=minecraft:item,distance=..8,nbt={Item:{id:"minecraft:paper",tag:{KitSoulWarrior:1b}}}] run function kitpvp:skill/soul/use_warrior
execute at @s if entity @e[type=minecraft:item,distance=..8,nbt={Item:{id:"minecraft:paper",tag:{KitSoulArcher:1b}}}] run function kitpvp:skill/soul/use_archer
execute at @s if entity @e[type=minecraft:item,distance=..8,nbt={Item:{id:"minecraft:paper",tag:{KitSoulTank:1b}}}] run function kitpvp:skill/soul/use_tank
execute at @s if entity @e[type=minecraft:item,distance=..8,nbt={Item:{id:"minecraft:paper",tag:{KitSoulAssassin:1b}}}] run function kitpvp:skill/soul/use_assassin
