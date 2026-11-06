# 内卫（Dominion）放烟花：每 2 秒一枚黑色烟花，贴地炸开，炸完留下约 2 秒的一团黑烟（烟雾弹那种）
# 烟不能只放一帧：玩家看得见的"浓"是"很多粒子在同一个地方反复补"——标记 + 每 2 刻补一轮，共 20 轮
scoreboard players set @s kitpvp.earth_cd_a 40

# 1) 真烟花：LifeTime 4 刻 ⇒ 刚起飞就炸；5 份 Type 1b 大球叠浓（海盗手炮那枚就是靠 Explosions 条数堆的）
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b},{Type:1b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
playsound minecraft:entity.warden.ambient master @a[distance=..24] ~ ~ ~ 1.0 0.5

# 2) 爆点埋标记 + 40 条命：4 刻后开始冒烟，每 2 刻减 1，减完自毁
#    寿命只给"刚埋的那一颗"设（临时标签 earth_fw_new），否则新烟花会给旧烟续命、最后所有烟一起消失
summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark","kitpvp.earth_fw_new"]}
scoreboard players set @e[tag=kitpvp.earth_fw_new,distance=..1,limit=1,sort=nearest] kitpvp.earth_fw_life 40
tag @e[tag=kitpvp.earth_fw_new] remove kitpvp.earth_fw_new
schedule function kitpvp:skill/earth/dominion_smoke 4t replace
