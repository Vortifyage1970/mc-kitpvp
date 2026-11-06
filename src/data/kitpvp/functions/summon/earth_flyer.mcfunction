# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 17 格；骷髅死则幻翼同死
# 三段式：本文件只清场 → 1 刻后 earth_flyer_spawn 召幻翼 → 再 1 刻后 earth_flyer_b 召吊舱
# 必须分帧：UUID 是写死的，同一刻内 add 会被 ServerLevel.addFreshEntity 的 UUID 查重挡掉（静默失败）
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
schedule function kitpvp:summon/earth_flyer_spawn 1t replace
