# 内卫（Dominion）放烟花：每 2 秒一枚黑色烟花，贴地炸开，炸完留下约 4 秒的一团黑烟（粒子用最初那版的 68 粒/轮）
# 烟用"标记 + 每 2 刻补一轮"堆出来：40 轮 × 68 粒 = 2720 粒/团；寿命只在自己出生时设一次 ⇒ 各团先后消散
# ★ 12 秒停烟：出生时给 kitpvp.dominion_smoke_time = 240，tick 每刻减 1；减到 0 之后就只放烟花、不再留烟
#   （烟花音画照旧，只是不再生成浓烟——这是为了防止开一局久了满场烟团把帧数拖死）
scoreboard players set @s kitpvp.earth_cd_a 40

# 1) 真烟花：LifeTime 4 刻 ⇒ 刚起飞就炸；5 份 Type 1b 大球叠浓（海盗手炮那枚就是靠 Explosions 条数堆的）
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
playsound minecraft:entity.warden.ambient master @a[distance=..24] ~ ~ ~ 1.0 0.5

# 2) 冒烟窗口内才埋标记（+80 条命 = 4 秒：4 刻后开始冒烟，每 2 刻减 1，减完自毁）
scoreboard players set #fw_mark_n kitpvp.game 0
execute store result score #fw_mark_n kitpvp.game if entity @e[tag=kitpvp.earth_fw_mark]
execute if score @s kitpvp.dominion_smoke_time matches 1.. if score #fw_mark_n kitpvp.game matches ..11 run summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark","kitpvp.earth_fw_new"]}
execute if score @s kitpvp.dominion_smoke_time matches 1.. if score #fw_mark_n kitpvp.game matches ..11 run scoreboard players set @e[tag=kitpvp.earth_fw_new,distance=..1,limit=1,sort=nearest] kitpvp.earth_fw_life 80
execute if score @s kitpvp.dominion_smoke_time matches 1.. if score #fw_mark_n kitpvp.game matches ..11 run tag @e[tag=kitpvp.earth_fw_new] remove kitpvp.earth_fw_new
execute if score @s kitpvp.dominion_smoke_time matches 1.. if score #fw_mark_n kitpvp.game matches ..11 run schedule function kitpvp:skill/earth/dominion_smoke 4t replace
