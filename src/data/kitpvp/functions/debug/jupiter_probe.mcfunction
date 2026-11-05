# 木星探针：/function kitpvp:debug/jupiter_probe
# 召唤一只木星 → 立刻用 /damage 打死 → 2 刻后自动打印状态（尸体还在 20 刻，抓得到）
# 输出里看三件事：尸体还在不在、hp 分数是不是 0、struck 标记有没有被打上
execute at @s run function kitpvp:summon/earth_jupiter
damage @e[type=minecraft:zombie,tag=kitpvp.earth_jupiter,distance=..3,sort=nearest,limit=1] 100 minecraft:generic
schedule function kitpvp:debug/jupiter_probe_after 2t replace
tellraw @s [{"text":"[探针] 木星已打死，2 刻后自动打印状态（同时应看到 chat 里的“抓到死亡帧”）","color":"gray"}]
