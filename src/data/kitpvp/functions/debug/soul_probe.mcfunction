# 魂石自检：把四种新魂石的 used / last 分数、以及场上 token / marker 的数量打出来
# 用法：/reload 之后 `/function kitpvp:debug/soul_probe`
# 判读：
#   used = 0            → 蛋用掉了但统计没涨（目标没建 / 不是那种蛋）
#   used > last         → 分发本该触发（如果没效果，问题在 use_* 里找 token）
#   used = last         → 已经消费过，需要再放一次蛋
#   token 数量 > 0      → 蛋生物没被清掉 ⇒ use_* 根本没跑（看上面两行）
tellraw @s [{"text":"═════ 魂石自检 ═════","color":"gold","bold":true}]
tellraw @s [{"text":"驯兽师 used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.soul_tamer_used"},"color":"aqua"},{"text":" / ","color":"dark_gray"},{"score":{"name":"@s","objective":"kitpvp.soul_tamer_last"},"color":"aqua"},{"text":"  token: ","color":"gray"},{"text":"见下","color":"white"}]
tellraw @s [{"text":"太阳   used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.soul_sun_used"},"color":"gold"},{"text":" / ","color":"dark_gray"},{"score":{"name":"@s","objective":"kitpvp.soul_sun_last"},"color":"gold"}]
tellraw @s [{"text":"水星   used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.soul_mercury_used"},"color":"aqua"},{"text":" / ","color":"dark_gray"},{"score":{"name":"@s","objective":"kitpvp.soul_mercury_last"},"color":"aqua"}]
tellraw @s [{"text":"金星   used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.soul_venus_used"},"color":"gold"},{"text":" / ","color":"dark_gray"},{"score":{"name":"@s","objective":"kitpvp.soul_venus_last"},"color":"gold"}]
# 场上残留（token 没被清 = use_* 没跑；marker / 狗在 = 已经在跑）
execute at @s run tellraw @s [{"text":"8 格内 token 生物数：","color":"gray"},{"selector":"@e[tag=kitpvp.soul_tamer_token,distance=..8]","color":"white"}]
execute at @s run tellraw @s [{"text":"8 格内驯兽师 marker：","color":"gray"},{"selector":"@e[tag=kitpvp.soul_tamer_marker,distance=..8]","color":"white"}]
execute at @s run tellraw @s [{"text":"8 格内金星舔狗：","color":"gray"},{"selector":"@e[tag=kitpvp.soul_venus_dog,distance=..8]","color":"white"}]
