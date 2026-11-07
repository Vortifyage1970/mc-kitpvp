# @s = 电磁炮：每刻数一次"15 格内有没有活人"，有就充能、没有就把充能泄掉
# 归属先归零再 operation：魂石链路/手动召的没有 earth_owner，源分缺失会留上一只的旧值
scoreboard players set #spk_owner kitpvp.game 0
scoreboard players operation #spk_owner kitpvp.game = @s kitpvp.earth_owner

# ★ 充能条件只看"15 格内有没有活人"，连召唤者也算 —— 单人测试时炮口前站的就是你自己，
#   以前要求"必须有一个不是召唤者的人"才充能，于是单人档里它永远不动、看起来像坏了。
#   伤害那边另有排除（sparky_burst 里跳过主人），所以充能不会变成误伤。
scoreboard players set #spk_on kitpvp.game 0
execute at @s if entity @a[distance=..15,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players set #spk_on kitpvp.game 1

# 没目标：充能清零（像皇家战争里收不到目标的炮，线圈冷却下来）
execute if score #spk_on kitpvp.game matches 0 run scoreboard players set @s kitpvp.sparky_charge 0

# 有目标：充能 +1，封顶 160（= 8 秒）
execute if score #spk_on kitpvp.game matches 1 run scoreboard players add @s kitpvp.sparky_charge 1
execute if score @s kitpvp.sparky_charge matches 161.. run scoreboard players set @s kitpvp.sparky_charge 160

# 充能中的音画反馈（电弧 / 升调滴声 / 蜂鸣 / 上膛声）：只在"有目标"时才响
execute if score #spk_on kitpvp.game matches 1 at @s run function kitpvp:skill/earth/sparky_charge_sfx

# 充满：朝 15 格内最近的活人放一炮（谁挨打由 sparky_burst 里的"跳过主人"决定）
execute if score @s kitpvp.sparky_charge matches 160 at @s run function kitpvp:skill/earth/sparky_fire
