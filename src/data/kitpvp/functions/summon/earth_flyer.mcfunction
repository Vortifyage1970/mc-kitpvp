# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 三段式（tick 派发，不用 schedule）：
#   本文件清场 + 在召唤者脚下放一个 marker 当锚点 + 置 #fl_spawn=1
#   → tick 下刻跑 earth_flyer_spawn 在锚点上召幻翼 + 置 #fl_body=1 → tick 再跑 earth_flyer_b 召吊舱
# 必须分帧且带锚点：UUID 写死（Leash 要用），同刻 add 会被 UUID 查重静默挡掉；tick 派发又丢了位置上下文
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
kill @e[tag=kitpvp.fl_anchor]
execute at @s run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.fl_anchor"]}
tellraw @a [{"text":"[飞行器] 已清场，下一刻召幻翼","color":"dark_gray"}]
scoreboard players set #fl_retry kitpvp.game 0
scoreboard players set #fl_spawn kitpvp.game 1
