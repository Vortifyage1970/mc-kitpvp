# @s = 里·农夫：清掉起义蛋的载体，就地召出领袖并归队
function kitpvp:skill/tainted_farmer/team_slot
execute at @s run kill @e[type=minecraft:mooshroom,name="开始一场起义"]
scoreboard players operation #tf_own kitpvp.game = @s kitpvp.tfid
execute at @s run function kitpvp:summon/tainted_farmer_leader
scoreboard players operation @e[tag=kitpvp.tf_new,type=minecraft:zombie] kitpvp.tf_owner = #tf_own kitpvp.game
execute as @e[tag=kitpvp.tf_new,type=minecraft:zombie] run function kitpvp:skill/tainted_farmer/join_own

scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_wave2 kitpvp.game 120

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"开始一场起义","color":"dark_green","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 0.9
