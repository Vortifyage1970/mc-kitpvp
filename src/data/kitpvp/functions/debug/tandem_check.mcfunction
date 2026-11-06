# 排查用：把每一只串联体的 ActiveEffects 原样打出来（@s = 玩家，站在它们旁边跑）
tellraw @s [{"text":"=== 串联体 ===","color":"gold","bold":true}]
tellraw @s [{"text":"只数 = "},{"score":{"name":"#td_n","objective":"kitpvp.game"},"color":"yellow"}]
execute store result score #td_n kitpvp.game run data get entity @e[tag=kitpvp.earth_tandem,distance=..24,limit=1,sort=nearest] Health
