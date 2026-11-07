# 排查用：走正常召唤路径（不挂 fl_test），看真人视角下到底冲不冲
# 用法：/reload 之后执行 /function kitpvp:debug/flyer_probe
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
tellraw @s [{"text":"[飞行器] 已清场，2 刻后按正常路径召唤，随后采样 24 秒","color":"gold"}]
schedule function kitpvp:debug/flyer_probe_b 2t replace
