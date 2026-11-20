# 爆炸陷阱：脚下召唤已引燃的苦力怕（mobGriefing=false → 只伤人不毁地形）
execute unless score @s kitpvp.trap_id matches 1 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:1b}
execute unless score @s kitpvp.trap_id matches 2 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:2b}
execute unless score @s kitpvp.trap_id matches 3 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:3b}
execute unless score @s kitpvp.trap_id matches 4 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:4b}
execute unless score @s kitpvp.trap_id matches 5 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:5b}
execute unless score @s kitpvp.trap_id matches 6 run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:6b}
summon minecraft:creeper ~ ~ ~ {Fuse:1,ignited:1b,ExplosionRadius:2b,Tags:["kitpvp.trap_boom_mob"]}
title @s actionbar {"text":"轰！","color":"dark_red"}
playsound minecraft:entity.tnt.primed master @s ~ ~ ~ 1 0.8
