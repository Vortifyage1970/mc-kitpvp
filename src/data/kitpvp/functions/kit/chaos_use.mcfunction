# 消耗一次：数到 0 就碎（记分板是权威，武器耐久条只是演出）
scoreboard players remove @s kitpvp.chaos_uses 1
execute unless score @s kitpvp.chaos_uses matches 1.. run function kitpvp:kit/chaos_break
