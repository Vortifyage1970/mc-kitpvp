# 内卫（Dominion）放烟花：每 2 秒一枚黑色烟花，贴地炸开，炸完留下约 1.4 秒的黑烟（烟雾弹那种）
# 烟不能只放一帧：玩家看得见的"浓"是"很多粒子在同一处反复补"——标记 + 每 2 刻补一轮、共 14 轮
# 阈值 `matches ..7` 的意思：场上已有 7 团（含这团最多 8 团）就不再新增；要更省改 `..3`，要更浓改 `..11`
# ★ 上限：场上最多 8 团烟同时存在（防多只内卫叠爆）。单只看不到这个上限：
#   它每 2 秒一发、每团只活 1.4 秒 ⇒ 同一时刻最多 1 团，永远不会自己压自己
scoreboard players set #fw_mark_n kitpvp.game 0
execute store result score #fw_mark_n kitpvp.game if entity @e[tag=kitpvp.earth_fw_mark]
scoreboard players set @s kitpvp.earth_cd_a 40
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
playsound minecraft:entity.warden.ambient master @a[distance=..24] ~ ~ ~ 1.0 0.5
execute if score #fw_mark_n kitpvp.game matches ..7 run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark"]}
execute if score #fw_mark_n kitpvp.game matches ..7 run scoreboard players set @e[tag=kitpvp.earth_fw_mark,distance=..1,limit=1,sort=nearest] kitpvp.earth_fw_life 28
execute if score #fw_mark_n kitpvp.game matches ..7 run schedule function kitpvp:skill/earth/dominion_smoke 4t replace
