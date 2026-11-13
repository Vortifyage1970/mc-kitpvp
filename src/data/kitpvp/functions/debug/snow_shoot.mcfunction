# 算弹道并丢出去。做法：把"目标坐标 − 自己眼睛坐标"换算成千分数，再乘一个固定系数写进雪球的 Motion。
# 1.20.1 没有宏、也没法直接算向量，这是不用 macro 的通用写法（以后要"会扔东西的怪"就抄这一套）
# 坐标全部 ×1000 存分数（data get 的 scale 会四舍五入，够用）
execute store result score #tx kitpvp.game run data get entity @p[distance=..15,gamemode=!spectator] Pos[0] 1000
execute store result score #ty kitpvp.game run data get entity @p[distance=..15,gamemode=!spectator] Pos[1] 1000
execute store result score #tz kitpvp.game run data get entity @p[distance=..15,gamemode=!spectator] Pos[2] 1000
execute store result score #ox kitpvp.game run data get entity @s Pos[0] 1000
execute store result score #oy kitpvp.game run data get entity @s Pos[1] 1000
execute store result score #oz kitpvp.game run data get entity @s Pos[2] 1000
# 瞄胸口（脚上方 1.1 格），出手点按眼睛高度（脚上方 1.6 格）
scoreboard players add #ty kitpvp.game 1100
scoreboard players add #oy kitpvp.game 1600
scoreboard players operation #dx kitpvp.game = #tx kitpvp.game
scoreboard players operation #dx kitpvp.game -= #ox kitpvp.game
scoreboard players operation #dy kitpvp.game = #ty kitpvp.game
scoreboard players operation #dy kitpvp.game -= #oy kitpvp.game
scoreboard players operation #dz kitpvp.game = #tz kitpvp.game
scoreboard players operation #dz kitpvp.game -= #oz kitpvp.game
# 从眼睛前方 0.7 格生成（朝向目标只是为了让雪球初始朝向对，速度完全由 Motion 决定）
execute anchored eyes facing entity @p[distance=..15,gamemode=!spectator] feet positioned ^ ^ ^0.7 run summon minecraft:snowball ~ ~ ~ {Tags:["kitpvp.snow","kitpvp.snow_new"]}
# 系数 0.00015：10 格远 → 每刻 1.5 格；近处自然变慢
execute store result entity @e[type=minecraft:snowball,tag=kitpvp.snow_new,limit=1,sort=nearest] Motion[0] double 0.00015 run scoreboard players get #dx kitpvp.game
execute store result entity @e[type=minecraft:snowball,tag=kitpvp.snow_new,limit=1,sort=nearest] Motion[1] double 0.00015 run scoreboard players get #dy kitpvp.game
execute store result entity @e[type=minecraft:snowball,tag=kitpvp.snow_new,limit=1,sort=nearest] Motion[2] double 0.00015 run scoreboard players get #dz kitpvp.game
tag @e[type=minecraft:snowball,tag=kitpvp.snow_new] remove kitpvp.snow_new
execute at @s run playsound minecraft:entity.snowball.throw hostile @a[distance=..16] ~ ~ ~ 0.8 1
