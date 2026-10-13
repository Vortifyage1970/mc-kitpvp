# cd<=0 重置炮弹为 1 发并进 30 秒冷却；set cd 必须在最后一行，否则后面的 ..0 判定全被拦死
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"换弹冷却中","color":"gray"}

execute if score @s kitpvp.cd matches ..0 run clear @s minecraft:firework_rocket{KitPirateRocket:1b}
execute if score @s kitpvp.cd matches ..0 run give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1
execute if score @s kitpvp.cd matches ..0 run title @s actionbar {"text":"换弹完成：手炮炮弹 ×1","color":"dark_blue"}
execute if score @s kitpvp.cd matches ..0 run playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.0
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 600
