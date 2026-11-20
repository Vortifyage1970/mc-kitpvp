# @s = 使用者：辞令 10 秒（200 刻）
# 使用侧也写 cd（同纵火狂）：计时中再用不重置，满仓用掉也不会被立刻补回
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 400
execute at @s run kill @e[type=minecraft:sniffer,tag=kitpvp.cizhi_token,distance=..8]

scoreboard players set @s kitpvp.cizhi_timer 200
tag @s add kitpvp.cz_buff
function kitpvp:skill/zhuzhiwu/cizhi_apply

title @s actionbar {"text":"辞令：攻击 -4 / 攻速 x10 / 护甲 +10 / 韧性 +10（10 秒）","color":"gold"}
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.8 1.2
