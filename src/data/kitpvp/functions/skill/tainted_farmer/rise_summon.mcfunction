# @s = 里·农夫：领袖生在蛋的落点（载体所在位置）；领队与归属沿用同一套队槽
function kitpvp:skill/tainted_farmer/team_slot
scoreboard players operation #tf_own kitpvp.game = @s kitpvp.tfid

execute as @e[type=minecraft:mooshroom,name="开始一场起义",limit=1] at @s run function kitpvp:summon/tainted_farmer_leader
# 载体没了（被打掉 / 落进虚空）就退回玩家脚下，保证技能不会白按
execute unless entity @e[type=minecraft:mooshroom,name="开始一场起义"] at @s run function kitpvp:summon/tainted_farmer_leader
execute at @s run kill @e[type=minecraft:mooshroom,name="开始一场起义"]

scoreboard players operation @e[tag=kitpvp.tf_new,type=minecraft:zombie] kitpvp.tf_owner = #tf_own kitpvp.game
execute as @e[tag=kitpvp.tf_new,type=minecraft:zombie] run function kitpvp:skill/tainted_farmer/join_own

scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_wave2 kitpvp.game 120

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"开始一场起义","color":"dark_green","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 0.9
