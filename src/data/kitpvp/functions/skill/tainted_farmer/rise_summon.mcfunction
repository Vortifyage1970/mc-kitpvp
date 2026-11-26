# @s = 里·农夫：领袖生在蛋的落点（载体所在位置）；队伍跟着主人走，绝不改主人的队
# 主人已经在某套队里（炮台 / 阴兵 / 生灵 / 炸弹兵…）就直接沿用那套，否则才开一个农民槽
function kitpvp:util/team_index
execute if score #steam kitpvp.game matches 0 run function kitpvp:skill/tainted_farmer/team_slot
function kitpvp:util/team_index

execute as @e[type=minecraft:mooshroom,name="开始一场起义",limit=1] at @s run function kitpvp:summon/tainted_farmer_leader
# 载体没了（被打掉 / 落进虚空）就退回玩家脚下，保证技能不会白按
execute unless entity @e[type=minecraft:mooshroom,name="开始一场起义"] at @s run function kitpvp:summon/tainted_farmer_leader
execute at @s run kill @e[type=minecraft:mooshroom,name="开始一场起义"]

# 领袖记住主人的队编号（1..36），后续石锄 / 木锄农民靠它归队
scoreboard players operation @e[tag=kitpvp.team_new] kitpvp.tf_owner = #steam kitpvp.game
function kitpvp:util/team_join

scoreboard players set #tf_wave kitpvp.game 240
scoreboard players set #tf_wave2 kitpvp.game 120

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"开始一场起义","color":"dark_green","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 0.9
