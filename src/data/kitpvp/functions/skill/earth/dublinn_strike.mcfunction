# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，也已经 NoAI 关掉脑子，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径早期没写 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 两种口径：有主（1..6）⇒ 2 格内"不是主人"的活人被打；无主（手动 /function，测试用）⇒ 谁都打，包括召唤者
# ★ 手感：60 刻（3 秒）一下、3 点、damage 类型用 magic
#   magic 的关键差异：不产生击退（mob_attack 会把人大力推开）；同时带 by 乘客僵尸，死亡信息才正常显示"被深池飞行兵 杀死了"
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 60

tag @a remove kitpvp.dl_victim

# 1) 有主：2 格内、不是主人的活人
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..2,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner kitpvp.game run tag @s add kitpvp.dl_victim

# 2) 无主：2 格内所有活人（含召唤者）
execute if score #dl_owner kitpvp.game matches ..0 at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..2,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.dl_victim

# 3) 挥刀前转向目标（持续的朝向在 tick.mcfunction:322 那条里）
execute as @e[tag=kitpvp.earth_dublinn_zombie] at @s facing entity @a[tag=kitpvp.dl_victim,sort=nearest,limit=1] feet run tp @s ~ ~ ~ ~ ~

# 4) 结算：3 点 magic（不回血、不击退），击杀算在乘客僵尸头上
execute as @a[tag=kitpvp.dl_victim] run damage @s 3 minecraft:magic by @e[tag=kitpvp.earth_dublinn_zombie,distance=..6,sort=nearest,limit=1]

tag @a remove kitpvp.dl_victim
