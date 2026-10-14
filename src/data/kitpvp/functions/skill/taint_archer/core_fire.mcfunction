# 冷却从"使用时"起算 2400 刻（120 秒），走第二技能槽 cd2；窗口 600 刻（30 秒）
# 令牌会把岩浆怪刷出来：先压成最小体型（尺寸没有 0，Size:1 就是最小）再杀，否则击杀时会分裂
# ⚠ data merge entity 要求选择器在加载期就能确定是单个实体，@e[...] 不带 limit=1 会让本文件整个不加载（见 04 §十）
# tag 来自蛋的 EntityTag（见 04 §五），所以不会误伤地图装饰生物
execute as @e[tag=kitpvp.token_core] run data merge entity @s {Size:1}
kill @e[tag=kitpvp.token_core]

tag @s add kitpvp.molten_core
scoreboard players set @s kitpvp.molten_core_timer 600
scoreboard players set @s kitpvp.cd2 2400

particle minecraft:lava ~ ~1 ~ 1.0 1.0 1.0 0.0 60
playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1.0 0.9

function kitpvp:skill/taint_archer/core_refresh

title @s actionbar [{"text":"熔火核心：","color":"gold"},{"score":{"name":"#buffcnt","objective":"kitpvp.game"},"color":"white"},{"text":" 个炮台进入熔火形态（30 秒）","color":"gold"}]
