# 最小化验证：一只牛当"绳子持有者"，下一刻再召一只牛/一只蠹虫去拴它
kill @e[tag=lt_holder]
kill @e[tag=lt_cow]
kill @e[tag=lt_fish]
summon minecraft:cow ~ ~ ~ {UUID:[I;1900002,1,1,1],Tags:["lt_holder"],CustomName:'{"text":"holder"}'}
schedule function kitpvp:debug/leash_probe2 1t replace
