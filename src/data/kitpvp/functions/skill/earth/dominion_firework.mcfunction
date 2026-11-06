# 内卫（Dominion）放烟花：每 2 秒一枚黑色烟花，贴地炸开，炸完留一团浓黑烟（约 1.6 秒）
# 浓的秘诀是"同一处反复补 + 一簇多个源"：每发并排埋 3 个标记，各自每 2 刻补一轮 ⇒ 体量 ×3
# 上限：场上最多 12 个标记（= 4 团），防多只内卫叠爆；单只内卫每 2 秒一发、每团 1.6 秒就清，最多同时 1 团
scoreboard players set #fw_mark_n kitpvp.game 0
execute store result score #fw_mark_n kitpvp.game if entity @e[tag=kitpvp.earth_fw_mark]
scoreboard players set @s kitpvp.earth_cd_a 40
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
playsound minecraft:entity.warden.ambient master @a[distance=..24] ~ ~ ~ 1.0 0.5
execute if score #fw_mark_n kitpvp.game matches ..11 run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark"]}
execute if score #fw_mark_n kitpvp.game matches ..11 run summon minecraft:marker ~1.2 ~1.6 ~ {Tags:["kitpvp.earth_fw_mark"]}
execute if score #fw_mark_n kitpvp.game matches ..11 run summon minecraft:marker ~-1.2 ~2.2 ~ {Tags:["kitpvp.earth_fw_mark"]}
execute if score #fw_mark_n kitpvp.game matches ..11 run scoreboard players set @e[tag=kitpvp.earth_fw_mark,scores={kitpvp.earth_fw_life=..0}] kitpvp.earth_fw_life 32
execute if score #fw_mark_n kitpvp.game matches ..11 run schedule function kitpvp:skill/earth/dominion_smoke 4t replace
