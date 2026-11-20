# 辞令状态（由 tick/kits_f 对带 kitpvp.cz_buff 的玩家每刻调用）
execute if score @s kitpvp.cizhi_timer matches 1.. run function kitpvp:skill/zhuzhiwu/cizhi_apply
execute if score @s kitpvp.cizhi_timer matches 1.. run scoreboard players remove @s kitpvp.cizhi_timer 1
execute if score @s kitpvp.cizhi_timer matches ..0 run function kitpvp:skill/zhuzhiwu/cizhi_remove
execute if score @s kitpvp.cizhi_timer matches ..0 run tag @s remove kitpvp.cz_buff
