# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，自己永远挥不了刀，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径早期没写 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 只有"有主人"（earth_owner = 1..6）才出手；没有主人的一律不动（无主分支以前是"见到就打"，会误伤召唤者）
# ★ 手感：每 15 刻（0.75 秒）一下、7 点伤害、3.5 格内所有非主人玩家 —— 以前只打"最近的那一个"，
#   而它追的是最近的玩家（常常就是召唤者）⇒ 最近那个是主人时，旁边站着的敌人反而白挨不到。现在改成范围内全打。
#   by 点名乘客僵尸 ⇒ 有击退、有击杀归属
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 15

# ① 没有主人（魂石路径早期 / 手动 /function 召出来的）：不出手

# ② 有主人：3.5 格内所有"不是主人"的活人一起吃 7 点（一次结算，谁靠近都一样）
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner kitpvp.game run damage @s 7 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1]
# 打到人时给一声"骨刀"反馈，方便判断到底有没有命中
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] if entity @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @a[distance=..3.5,sort=nearest] kitpvp.etid = #dl_owner kitpvp.game run playsound minecraft:entity.player.attack.sweep master @a[distance=..12] ~ ~ ~ 0.9 1.4
