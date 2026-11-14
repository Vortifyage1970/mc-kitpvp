# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.soul_mars_last = @s kitpvp.soul_mars_used

# 上一发还没结束就再用：先收掉旧巨人，避免两只叠在一起
execute if entity @s[tag=kitpvp.soul_mars_active] run function kitpvp:skill/soul/mars_expire

# 清掉刷怪蛋刷出的那只劫掠兽（载体）
execute at @s run kill @e[type=minecraft:ravager,tag=kitpvp.soul_mars_token,distance=..16]

tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"火星魂石·地鸣","color":"dark_red","bold":true},{"text":" ❖","color":"gold","bold":true}]
execute as @a at @s run playsound minecraft:entity.warden.roar master @s ~ ~ ~ 0.9 0.7
execute as @a at @s run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 0.8 0.6

execute at @s run function kitpvp:skill/soul/mars_spawn

tag @s add kitpvp.soul_mars_active
scoreboard players set @s kitpvp.soul_mars_timer 400

# 歌曲从最后 20 秒进入。引擎口径：每个 NBS 音 80 分、每刻 +154 分；
# 全曲最后一个音是 3472（277760 分），留 400 刻 = 61600 分 ⇒ 起点 216160 分（第 2702 个音）。
# 快照推到 2701，让首个能响的音是 2702（叶子守卫是 `nbs_rumbling_t=..T-1`，见 music/rumbling/tree/*）
execute as @a run function kitpvp:music/rumbling/play
execute as @a run scoreboard players set @s nbs_rumbling 216160
execute as @a run scoreboard players set @s nbs_rumbling_t 2701

title @s actionbar {"text":"魂石·地鸣：巨人 20 秒","color":"dark_red"}
