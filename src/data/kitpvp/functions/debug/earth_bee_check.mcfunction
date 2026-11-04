# 排查大蜜蜂用：站在它旁边执行，告诉你 10 格内还有几只
# 用法：/function kitpvp:debug/earth_bee_check
# 输出 0 只 ⇒ 它已经飞远或被打死了，光环当然照不到你
scoreboard players set #bee_near kitpvp.game 0
execute at @s as @e[tag=kitpvp.earth_bigbee,distance=..10] run scoreboard players add #bee_near kitpvp.game 1
tellraw @s [{"text":"[调试] 10 格内的大蜜蜂：","color":"yellow"},{"score":{"name":"#bee_near","objective":"kitpvp.game"},"color":"aqua"},{"text":" 只（0 只说明它飞远了或已经死了）","color":"gray"}]
