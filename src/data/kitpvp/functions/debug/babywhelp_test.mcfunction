# 单人测飞龙宝宝：清场 → 在你正前方 6 格召一只 → 每 1 秒报一次状态（共 8 次）
# ⚠ 测试请切到生存模式：创造模式下 damage 对玩家无效，看起来像"没打中"
kill @e[tag=kitpvp.earth_babywhelp]
kill @e[tag=kitpvp.bw_ball]
execute at @s positioned ^ ^ ^6 run function kitpvp:summon/earth_babywhelp
scoreboard players set #bw_probe kitpvp.game 8
tellraw @s [{"text":"[飞龙宝宝] 已在正前方 6 格召出，站原地别动，看它每 5 秒吐一发","color":"dark_purple"}]
schedule function kitpvp:debug/babywhelp_probe 20t
