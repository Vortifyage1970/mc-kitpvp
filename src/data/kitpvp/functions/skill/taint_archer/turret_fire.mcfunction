# 就地生成：刷怪蛋已经按玩家的瞄点刷出一只流浪者，炮台就起在它那个位置（找不到才退化到脚下）
# 靠蛋的 EntityTag 打的 tag 认它，不用生物名字
scoreboard players set #tfound kitpvp.game 0
execute if entity @e[tag=kitpvp.token_turret] run scoreboard players set #tfound kitpvp.game 1
execute at @e[tag=kitpvp.token_turret,sort=nearest,limit=1] run function kitpvp:summon/turret
execute if score #tfound kitpvp.game matches 0 at @s run function kitpvp:summon/turret
kill @e[tag=kitpvp.token_turret]

# 归属与排序：队槽只用于"不攻击主人"，主人编号与序号用分数记（选择器里比不了变量）
# ⚠ 必须把**玩家和炮台都** join 进同一队：只 join 炮台的话玩家不在队里，骷髅照样打他
scoreboard players add #turret_seq kitpvp.game 1
scoreboard players operation @e[tag=kitpvp.turret_new] kitpvp.turret_seq = #turret_seq kitpvp.game
scoreboard players operation @e[tag=kitpvp.turret_new] kitpvp.turret_owner = @s kitpvp.ttid

execute if score @s kitpvp.ttid matches 1 run team join turret_1 @s
execute if score @s kitpvp.ttid matches 2 run team join turret_2 @s
execute if score @s kitpvp.ttid matches 3 run team join turret_3 @s
execute if score @s kitpvp.ttid matches 4 run team join turret_4 @s
execute if score @s kitpvp.ttid matches 5 run team join turret_5 @s
execute if score @s kitpvp.ttid matches 6 run team join turret_6 @s

execute if score @s kitpvp.ttid matches 1 run team join turret_1 @e[tag=kitpvp.turret_new]
execute if score @s kitpvp.ttid matches 2 run team join turret_2 @e[tag=kitpvp.turret_new]
execute if score @s kitpvp.ttid matches 3 run team join turret_3 @e[tag=kitpvp.turret_new]
execute if score @s kitpvp.ttid matches 4 run team join turret_4 @e[tag=kitpvp.turret_new]
execute if score @s kitpvp.ttid matches 5 run team join turret_5 @e[tag=kitpvp.turret_new]
execute if score @s kitpvp.ttid matches 6 run team join turret_6 @e[tag=kitpvp.turret_new]

tag @e remove kitpvp.turret_new

# 存在上限 3：超过就杀掉自己序号最小（最早）的那个；新炮台序号最大，不会被自己杀掉
scoreboard players operation #ttid kitpvp.game = @s kitpvp.ttid
scoreboard players set #tcnt kitpvp.game 0
execute as @e[tag=kitpvp.turret] if score @s kitpvp.turret_owner = #ttid kitpvp.game run scoreboard players add #tcnt kitpvp.game 1
scoreboard players set #tmin kitpvp.game 2147483647
execute if score #tcnt kitpvp.game matches 4.. as @e[tag=kitpvp.turret] if score @s kitpvp.turret_owner = #ttid kitpvp.game run scoreboard players operation #tmin kitpvp.game < @s kitpvp.turret_seq
execute if score #tcnt kitpvp.game matches 4.. as @e[tag=kitpvp.turret] if score @s kitpvp.turret_owner = #ttid kitpvp.game if score @s kitpvp.turret_seq = #tmin kitpvp.game run kill @s

title @s actionbar {"text":"炮台已部署（存在上限 3）","color":"dark_red"}
playsound minecraft:block.piston.extend master @s ~ ~ ~ 0.8 1.0

# 部署一个就进补货计时：满仓部署也要等满 60 秒才补回令牌。
# ..0 守卫：计时中再部署不重置，否则连续部署会把补货推得越来越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 1200
