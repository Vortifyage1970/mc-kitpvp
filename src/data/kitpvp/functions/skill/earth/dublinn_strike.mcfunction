# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，自己永远挥不了刀，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径没有 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 分两种情况，这是上一版"打不到人"的真凶：手动召出来的这只没有 earth_owner（=0），而没召唤过地球生灵的玩家
#   etid 也是 0（game/start_impl.mcfunction:25 每局清零），两个 0 相等 ⇒ 老写法把自己当成"主人"从而永不出手。
#   所以有主人（1..6）才比 etid，没有主人（..0）就谁都打。
# 手感：每 20 刻（1 秒）一下、5 点伤害、2 格内（停手距离是 1.5 格，2 格刚好够得着）；by 点名乘客僵尸 ⇒ 有击退、有击杀归属
# ★ 已进随机池（54 号）：summon 里的蠹虫带了 earth_minion / earth_minion_new / earth_mount，link 会赋 earth_owner 并组队
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 20

# ① 没有主人：见到就打
execute if score #dl_owner kitpvp.game matches ..0 at @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1] as @p[distance=..2,sort=nearest] run damage @s 5 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1]

# ② 有主人：只打"最近的那个玩家"，而且他不能是主人
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1] as @p[distance=..2,sort=nearest] unless score @s kitpvp.etid = #dl_owner kitpvp.game run damage @s 5 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1]