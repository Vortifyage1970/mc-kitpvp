# 结算后补扫驯兽师狼（由 game/reset 末尾 schedule 起 20 刻）
# 玩家被传送回大厅时，狼会在随后一两刻跟主人传送过去；reset 当场那次 kill 早了一刻，扫不到它，
# 于是它留在走廊里活到下一局（见 04 §五）
# 只在 #state=0（大厅）里扫，连扫 4 轮防漏；新一局开始就自然停下
# 只在 #state=0（大厅）里扫，连扫 4 轮防漏；新一局开始就自然停下（也不会误杀新一局刚放的狼）
execute if score #state kitpvp.game matches 0 run kill @e[tag=kitpvp.tamer_wolf]
scoreboard players add #wolfsweep kitpvp.game 1

execute if score #state kitpvp.game matches 0 if score #wolfsweep kitpvp.game matches ..3 run schedule function kitpvp:game/wolf_sweep 40t replace
execute unless score #wolfsweep kitpvp.game matches ..3 run scoreboard players set #wolfsweep kitpvp.game 0
