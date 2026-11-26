# 15 秒到：瞬间伤害 II（= 6 点），结算完把 pending 收回 -1
scoreboard players set @s kitpvp.halley_pending -1
effect give @s minecraft:instant_damage 1 1 true
tellraw @s [{"text":"高温灼烧","color":"red"}]
playsound minecraft:entity.blaze.hurt master @s ~ ~ ~ 1 0.8
