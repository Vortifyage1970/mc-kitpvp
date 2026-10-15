# 「苍」前摇计时：30 → 0 刻。20 / 10 刻各报幕一句，归零那刻释放（= 起手后 1.5 秒）。
# 释放那一刻报第三句「术式顺转·「苍」」，所以四句报幕的间隔正好是 10 刻（0.5 秒）
execute if score @s kitpvp.tainted_fisher_cang_timer matches 20 run tellraw @a [{"text":"◈　","color":"gold"},{"text":"黄","color":"yellow","bold":true},{"text":"昏","color":"gold","bold":true},{"text":"　◈","color":"gold"}]
execute if score @s kitpvp.tainted_fisher_cang_timer matches 20 as @a at @s run playsound minecraft:entity.evoker.cast_spell master @s ~ ~ ~ 0.6 1.2
execute if score @s kitpvp.tainted_fisher_cang_timer matches 10 run tellraw @a [{"text":"◈　","color":"gold"},{"text":"智","color":"gold","bold":true},{"text":"慧","color":"yellow","bold":true},{"text":"之","color":"yellow","bold":true},{"text":"瞳","color":"gold","bold":true},{"text":"　◈","color":"gold"}]
execute if score @s kitpvp.tainted_fisher_cang_timer matches 10 as @a at @s run playsound minecraft:block.conduit.ambient master @s ~ ~ ~ 0.7 1.4

execute if score @s kitpvp.tainted_fisher_cang_timer matches 1.. run scoreboard players remove @s kitpvp.tainted_fisher_cang_timer 1
execute if score @s kitpvp.tainted_fisher_cang_timer matches ..0 run function kitpvp:skill/tainted_fisher/cang_release
