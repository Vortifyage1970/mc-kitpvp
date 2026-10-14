# 冷却从"使用时"起算 2400 刻（120 秒）；窗口 600 刻（30 秒）
tag @s add kitpvp.molten_core
scoreboard players set @s kitpvp.molten_core_timer 600

function kitpvp:skill/taint_archer/core_refresh

scoreboard players set @s kitpvp.cd2 2400

title @s actionbar {"text":"熔火核心：7 格内的炮台进入熔火形态（30 秒）","color":"gold"}
playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 0.8 1.0
