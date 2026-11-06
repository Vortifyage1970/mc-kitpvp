# 内卫（Dominion）放烟花：每 2 秒一枚黑色烟花，贴地炸开，炸完留下约 1.2 秒的黑烟（烟雾弹那种）
# 烟不能只放一帧：玩家看得见的"浓"是"很多粒子在同一处反复补"——标记 + 每 2 刻补一轮、共 12 轮
# 阈值 `matches ..3` 的意思：场上已有 3 团（含这团最多 4 团）就不再新增；要更省改 `..1`，要更浓改 `..5`
# ★ 上限：场上最多 4 团烟同时存在。烟是"每 2 刻补一轮 × 多团叠加"最费帧的东西，
#   内卫一多就会自己压自己：超了就不再埋新标记（烟花照放，只是不留烟团）
scoreboard players set #fw_mark_n kitpvp.game 0
execute store result score #fw_mark_n kitpvp.game if entity @e[tag=kitpvp.earth_fw_mark]
scoreboard players set @s kitpvp.earth_cd_a 40
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
playsound minecraft:entity.warden.ambient master @a[distance=..24] ~ ~ ~ 1.0 0.5
execute if score #fw_mark_n kitpvp.game matches ..3 run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark"]}
execute if score #fw_mark_n kitpvp.game matches ..3 run scoreboard players set @e[tag=kitpvp.earth_fw_mark,distance=..1,limit=1,sort=nearest] kitpvp.earth_fw_life 24
execute if score #fw_mark_n kitpvp.game matches ..3 run schedule function kitpvp:skill/earth/dominion_smoke 4t replace
