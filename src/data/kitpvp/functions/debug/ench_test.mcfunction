# 立即给最近的玩家触发一次强化（测试用）
tellraw @a {"text":"[附魔师] 立即强化一次","color":"light_purple"}
execute as @p at @s run scoreboard players set @s kitpvp.ench_sw 3
execute as @p at @s run function kitpvp:skill/enchanter/up_sword
execute as @p at @s run scoreboard players set @s kitpvp.ench_ap 3
execute as @p at @s run function kitpvp:skill/enchanter/up_armor
