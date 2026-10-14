# 冷却从"使用时"起算 2400 刻（120 秒），走第二技能槽 cd2
# 只在使用瞬间变一次：7 格内自己的炮台进入熔火形态，各自计时 30 秒后由 tick 复原，之后不再持续更新
# 令牌的载体是烈焰人（与战士魂石共用 blaze_spawn_egg，dispatch 按名字分流）：就地清掉
kill @e[type=minecraft:blaze,tag=kitpvp.token_core]
kill @e[type=minecraft:blaze,name="熔火核心"]

scoreboard players set @s kitpvp.cd2 2400

particle minecraft:lava ~ ~1 ~ 1.0 1.0 1.0 0.0 60
playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1.0 0.9

function kitpvp:skill/taint_archer/core_apply

title @s actionbar [{"text":"熔火核心：","color":"gold"},{"score":{"name":"#buffcnt","objective":"kitpvp.game"},"color":"white"},{"text":" 个炮台进入熔火形态（30 秒）","color":"gold"}]
