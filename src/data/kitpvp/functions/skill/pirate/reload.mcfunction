# cd<=0 重置炮弹为 1 发并进 30 秒冷却；set cd 必须在最后一行，否则后面的 ..0 判定全被拦死
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"换弹冷却中","color":"gray"}

# 已装填的手炮算作"已有弹药"：否则可以装填后再换弹，攒成 2 发
# clear ... 0 只计数不清除；Charged 是字节，必须按值匹配（判路径会把射击后的 0b 也算成已装填）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.tmp 0
execute if score @s kitpvp.cd matches ..0 store result score @s kitpvp.tmp run clear @s minecraft:crossbow{KitCrossbow:1b,Charged:1b} 0
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.tmp matches 1.. run title @s actionbar {"text":"手炮已装填，无需换弹","color":"gray"}

execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.tmp matches 0 run clear @s minecraft:firework_rocket{KitPirateRocket:1b}
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.tmp matches 0 run give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.tmp matches 0 run title @s actionbar {"text":"换弹完成：手炮炮弹 ×1","color":"dark_blue"}
execute if score @s kitpvp.cd matches ..0 if score @s kitpvp.tmp matches 0 run playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.0
execute if score @s kitpvp.cd matches ..0 run tag @s add kitpvp.pirate_reload_cd
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 600
