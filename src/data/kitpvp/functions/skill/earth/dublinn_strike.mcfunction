# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，也已经 NoAI 关掉脑子，所以这里替它出手
# 主人过滤：先归零再 operation（魂石路径早期没写 earth_owner，源分缺失会让 operation 失败留旧值）
# ★ 两种口径：有主（1..6）⇒ 3.5 格内"不是主人"的活人被打；无主（手动 /function，测试用）⇒ 谁都打，包括召唤者
# ★ 手感：20 刻（1 秒）一下、5 点、无来源伤害（damage ... minecraft:mob_attack）
# ★ 结构：先"筛人打标记"、再"对标记发伤害"、最后报命中数 —— 三段分开才能看出到底卡在哪一段
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 20

# 0) 清掉上一轮的标记
tag @a remove kitpvp.dl_victim

# 1) 有主：3.5 格内、不是主人的活人
execute if score #dl_owner kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner kitpvp.game run tag @s add kitpvp.dl_victim

# 2) 无主：3.5 格内所有活人（含召唤者）
execute if score #dl_owner kitpvp.game matches ..0 at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.dl_victim

# 3) 对标记过的人发伤害（无来源；带 by 的写法在这台机器上不出伤害，已实测排除）
execute as @a[tag=kitpvp.dl_victim] at @s run damage @s 5 minecraft:mob_attack

# 4) 命中反馈：骨刀音 + actionbar 报"这一下打了几个人"，命中数为 0 时不报（避免刷屏）
scoreboard players set #dl_hit kitpvp.game 0
execute store result score #dl_hit kitpvp.game if entity @a[tag=kitpvp.dl_victim]
execute if score #dl_hit kitpvp.game matches 1.. at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] run playsound minecraft:entity.player.attack.sweep master @a[distance=..12] ~ ~ ~ 0.9 1.4
execute if score #dl_hit kitpvp.game matches 1.. as @a[tag=kitpvp.dl_victim] run title @s actionbar [{"text":"深池 命中 -5","color":"gray"},{"text":"（这一下共 ","color":"dark_gray"},{"score":{"name":"#dl_hit","objective":"kitpvp.game"},"color":"yellow"},{"text":" 人）","color":"dark_gray"}]
tag @a remove kitpvp.dl_victim
