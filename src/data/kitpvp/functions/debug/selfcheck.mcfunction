# 自检（排查"改了没反应"）：把当前数据包版本和关键召唤物的数量打在聊天栏
# 用法：/reload 之后执行 /function kitpvp:debug/selfcheck
# 如果这条命令报 Unknown function ⇒ 游戏里跑的是旧副本，仓库这一版根本没进去（先解决这个再谈效果）
# 如果构建号不是下面这串 ⇒ 同样是旧副本
tellraw @a [{"text":"========== 数据包自检 ==========","color":"gold"}]
tellraw @a [{"text":"构建：","color":"gray"},{"text":"2026-11-05 深夜 · 木星尸体雷 / 术战士 HurtTime / 大蜜蜂 III / 蠹虫 IV+V","color":"aqua"}]

# tick 探针：tick.mcfunction 第一行每刻 +1
tellraw @a [{"text":"tick 探针计数：","color":"gray"},{"score":{"name":"#tick_probe","objective":"kitpvp.game"},"color":"green"},{"text":"（两次执行之间应该涨了几十，不涨就是 tick 没跑）","color":"dark_gray"}]

# 场上各类召唤物数量
scoreboard players set #n_bee kitpvp.game 0
execute as @e[tag=kitpvp.earth_bigbee] run scoreboard players add #n_bee kitpvp.game 1
scoreboard players set #n_blade kitpvp.game 0
execute as @e[tag=kitpvp.earth_spellblade] run scoreboard players add #n_blade kitpvp.game 1
scoreboard players set #n_vag kitpvp.game 0
execute as @e[tag=kitpvp.earth_vagrant] run scoreboard players add #n_vag kitpvp.game 1
scoreboard players set #n_jup kitpvp.game 0
execute as @e[tag=kitpvp.earth_jupiter] run scoreboard players add #n_jup kitpvp.game 1
scoreboard players set #n_car kitpvp.game 0
execute as @e[tag=kitpvp.earth_minecart] run scoreboard players add #n_car kitpvp.game 1
tellraw @a [{"text":"场上：大蜜蜂 ","color":"gray"},{"score":{"name":"#n_bee","objective":"kitpvp.game"},"color":"aqua"},{"text":" / 术战士 ","color":"gray"},{"score":{"name":"#n_blade","objective":"kitpvp.game"},"color":"aqua"},{"text":" / 流浪汉 ","color":"gray"},{"score":{"name":"#n_vag","objective":"kitpvp.game"},"color":"aqua"},{"text":" / 木星 ","color":"gray"},{"score":{"name":"#n_jup","objective":"kitpvp.game"},"color":"aqua"},{"text":" / 矿车 ","color":"gray"},{"score":{"name":"#n_car","objective":"kitpvp.game"},"color":"aqua"}]
tellraw @a [{"text":"========== 自检结束 ==========","color":"gold"}]
