# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，自己永远挥不了刀，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径早期没写 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 只有"有主人"（earth_owner = 1..6）才出手；没有主人的一律不动 —— 以前无主分支是"见到就打"，
#   结果魂石召出来的深池 earth_owner=0，把召唤者当成敌人打，这就是那个误伤 bug。
# 手感：每 20 刻（1 秒）一下、5 点伤害、2 格内（停手距离是 1.5 格，2 格刚好够得着）；by 点名乘客僵尸 ⇒ 有击退、有击杀归属
# ★ 50 号已进随机池：summon 里蠹虫带 earth_minion / earth_minion_new / earth_mount，link 会赋 earth_owner 并组队；
#   魂石路径现在也由 skill/soul/earth_step 写 earth_owner，所以两种召法都认得出主人
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 15

# ① 没有主人（魂石路径 / 手动 /function 召出来的）：不出手
# ★ 这里以前写的是"见到就打"，结果魂石召的深池 earth_owner=0，会把自己召唤者当敌人打 —— 那条已经删掉

# ② 有主人：只打"最近的那个玩家"，而且他不能是主人
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @p[distance=..3,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner kitpvp.game run damage @s 7 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1]
