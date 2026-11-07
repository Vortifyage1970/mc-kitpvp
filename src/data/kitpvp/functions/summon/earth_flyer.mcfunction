# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 三段式（用 tick 派发，不用 schedule —— schedule 在这套环境里没跑起来过）：
#   本文件清场并置 #fl_spawn=1 → tick 下一刻跑 earth_flyer_spawn 召幻翼 → 置 #fl_body=1 → tick 再跑 earth_flyer_b 召吊舱
# 必须分帧：UUID 是写死的，同一刻 add 会被 ServerLevel.addFreshEntity 的 UUID 查重静默挡掉
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
tellraw @a [{"text":"[飞行器] 已清场，下一刻召幻翼","color":"dark_gray"}]
scoreboard players set #fl_retry kitpvp.game 0
scoreboard players set #fl_spawn kitpvp.game 1
