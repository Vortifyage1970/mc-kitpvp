# 首行推进快照；发 4 把已装填手炮，20 秒后由 pirate_expire 收回
scoreboard players operation @s kitpvp.soul_pirate_last = @s kitpvp.soul_pirate_used

execute at @s run kill @e[type=minecraft:pillager,name="海盗魂石"]

# 重复触发只保留一批：先清掉本职业自己的魂石手炮再发
clear @s minecraft:crossbow{KitSoulPirateCrossbow:1b}
# 装填的火箭与 kit/pirate 逐字一致（3 颗烟火之星、深蓝 0x003366）
give @s minecraft:crossbow{KitSoulPirateCrossbow:1b,Unbreakable:1b,Charged:1b,ChargedProjectiles:[{id:"minecraft:firework_rocket",Count:1b,tag:{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}}}],display:{Name:'{"text":"魂石手炮","color":"dark_blue","bold":true}'}} 4

tag @s add kitpvp.soul_pirate_held
scoreboard players set @s kitpvp.soul_pirate_timer 400

title @s actionbar {"text":"魂石·手炮：4 把装填手炮（20 秒）","color":"dark_blue"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.0
