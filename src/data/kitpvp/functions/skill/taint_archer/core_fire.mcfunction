# 冷却从"使用时"起算 2400 刻（120 秒），走第二技能槽 cd2；窗口 600 刻（30 秒）
# 令牌会把岩浆怪刷出来：先压成最小体型再杀，否则击杀时会分裂成一堆小的
data merge entity @e[type=minecraft:magma_cube,name="熔火核心"] {Size:1}
kill @e[type=minecraft:magma_cube,name="熔火核心"]

tag @s add kitpvp.molten_core
scoreboard players set @s kitpvp.molten_core_timer 600
scoreboard players set @s kitpvp.cd2 2400

particle minecraft:lava ~ ~1 ~ 1.0 1.0 1.0 0.0 60
playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1.0 0.9

function kitpvp:skill/taint_archer/core_refresh

title @s actionbar [{"text":"熔火核心：","color":"gold"},{"score":{"name":"#buffcnt","objective":"kitpvp.game"},"color":"white"},{"text":" 个炮台进入熔火形态（30 秒）","color":"gold"}]
