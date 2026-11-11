# 驯兽师魂石：首行推进快照（cat 蛋只在本魂石里发）
scoreboard players operation @s kitpvp.soul_tamer_last = @s kitpvp.soul_tamer_used

# 必须先把执行位置落到玩家身上：tick 里是 `as @a ... run function` 进来的，位置还在世界出生点，
# 直接写 `distance=..8` 会拿出生点当原点，既选不到脚边的载体、也会让"有没有 tag 载体"的判断永远为真（见 02 §八）
execute at @s run function kitpvp:skill/soul/tamer_at
