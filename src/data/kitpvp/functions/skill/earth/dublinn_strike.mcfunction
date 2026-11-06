# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，也已经被 NoAI 关掉脑子，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径早期没写 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 两种口径：
#   有主（earth_owner 1..6，随机池 / 魂石召出来的）⇒ 3.5 格内所有"不是主人"的活人一起吃伤害
#   无主（手动 /function 召唤，测试用）⇒ 谁都打，包括召唤者 —— 这样你一个人也能验伤害
# ★ 手感：15 刻（0.75 秒）一下、7 点、by 点名乘客僵尸（有击退、有击杀归属）
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 15

# ① 有主：排除召唤者
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner kitpvp.game run damage @s 7 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1]

# ② 无主：不排除任何人
execute if score #dl_owner kitpvp.game matches ..0 at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run damage @s 7 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1]

# 打到人时的骨刀音（有主/无主都放），用来判断到底有没有命中
execute at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] unless score @a[distance=..3.5,sort=nearest] kitpvp.etid = #dl_owner kitpvp.game if score #dl_owner kitpvp.game matches 1.. run playsound minecraft:entity.player.attack.sweep master @a[distance=..12] ~ ~ ~ 0.9 1.4
execute at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] if score #dl_owner kitpvp.game matches ..0 if entity @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run playsound minecraft:entity.player.attack.sweep master @a[distance=..12] ~ ~ ~ 0.9 1.4
