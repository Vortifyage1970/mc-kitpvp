tellraw @a [{"text":"[测试 2/3] mob_attack 无来源 2 点","color":"gold"}]
execute as @a run damage @s 2 minecraft:mob_attack
schedule function kitpvp:debug/damage_probe_3 15t replace
