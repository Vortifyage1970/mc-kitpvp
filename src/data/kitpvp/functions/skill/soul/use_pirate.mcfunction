# 首行推进快照；发 1 把未装填的大型手炮（多重射击）+ 3 发炮弹，20 秒后由 pirate_expire 收回
scoreboard players operation @s kitpvp.soul_pirate_last = @s kitpvp.soul_pirate_used

execute at @s run kill @e[type=minecraft:pillager,name="海盗魂石"]

# 重复触发只保留一批：魂石手炮先清再发；散装炮弹与 kit/pirate 是同一种东西（同 NBT），
# 所以这里清掉的是"全部炮弹"，发完正好 3 发，不会随着每次魂石累积
clear @s minecraft:crossbow{KitSoulPirateCrossbow:1b}
clear @s minecraft:firework_rocket{KitPirateRocket:1b}
give @s minecraft:crossbow{KitSoulPirateCrossbow:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:multishot",lvl:1}],display:{Name:'{"text":"大型手炮","color":"dark_blue"}'}} 1
# 未装填：不写 Charged / ChargedProjectiles，玩家得自己把炮弹装上（与 kit/pirate 的手炮一致）
# 炮弹与 kit/pirate 逐字一致（3 颗烟火之星、深蓝 0x003366）
give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 3

tag @s add kitpvp.soul_pirate_held
scoreboard players set @s kitpvp.soul_pirate_timer 400

title @s actionbar {"text":"魂石·大型手炮：1 把多重射击手炮 + 3 发炮弹（20 秒）","color":"dark_blue"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.0
