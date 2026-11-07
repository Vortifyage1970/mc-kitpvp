# 排查用：单人也能测飞行器俯冲
# 用法：/reload 之后执行 /function kitpvp:debug/flyer_test
# 它会把旧的一对清掉（等 2 刻再召 —— 同一刻 kill + summon 同 UUID 会静默失败），
# 在召唤者头顶约 27 格召一只，然后每 5 秒扑一次，聊天栏每秒打一行 Y / 计时 / 有没有靶子，共 12 行
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
tellraw @s [{"text":"[飞行器] 已清场，2 刻后重召，随后采样 12 秒","color":"gold"}]
schedule function kitpvp:debug/flyer_test_b 2t replace
