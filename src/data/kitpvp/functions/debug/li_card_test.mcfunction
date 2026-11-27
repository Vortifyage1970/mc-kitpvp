# 里·附魔师卡牌自测（逐刻版）：18 张卡每 3 刻打一张，动作栏一条条看得清
# 上一版同一刻连打 18 张，actionbar 互相覆盖，只剩最后一条
tellraw @s [{"text":"[自测] 18 张卡逐张触发（每 3 刻一张），盯动作栏","color":"yellow"}]
scoreboard players set #li_step kitpvp.game 0
schedule function kitpvp:debug/li_card_step 2t replace
