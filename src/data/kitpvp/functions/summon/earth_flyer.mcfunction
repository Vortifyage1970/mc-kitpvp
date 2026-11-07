# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 复用优先：UUID 写死（Leash 要用），addFreshEntity 遇到已存在的 UUID 会静默失败，
#   所以场上已有母体时什么都不做——不杀、不召、也不搬动它（本体的行为保持最初那一版）；
#   只有场上没有母体时才走三段式（清场 → 幻翼 → 吊舱，每帧一步，避开 UUID 查重窗口）
execute if entity @e[tag=kitpvp.earth_flyer_carrier] unless entity @e[tag=kitpvp.earth_flyer_body] run scoreboard players set @e[tag=kitpvp.earth_flyer_carrier] kitpvp.flyer_grace 10
execute if entity @e[tag=kitpvp.earth_flyer_carrier] unless entity @e[tag=kitpvp.earth_flyer_body] run scoreboard players set #fl_retry kitpvp.game 0
execute if entity @e[tag=kitpvp.earth_flyer_carrier] unless entity @e[tag=kitpvp.earth_flyer_body] run scoreboard players set #fl_body kitpvp.game 1
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run kill @e[tag=kitpvp.earth_flyer_body]
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run kill @e[tag=kitpvp.fl_anchor]
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] at @s run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.fl_anchor"]}
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_retry kitpvp.game 0
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run scoreboard players set #fl_spawn kitpvp.game 1