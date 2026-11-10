# @s = 玩家；执行位置 = 出口门
# 关键：全程**不改玩家视角**（tp 只给位置、不给旋转）。改视角那一下是高台跳进门"不丝滑"的主因，
# 这里只搬身体，镜头自己接着用，出门后玩家看到的还是自己原来的朝向。
# 第一步：认出出口是哪类门（0 墙 / 1 地面 / 2 天花板）
scoreboard players set #tep_face kitpvp.game 0
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2

# 第二步：按门的类型把脚放到合适高度（墙 1.55 / 地面 0.9 / 天花板 2.0）
execute if score #tep_face kitpvp.game matches 0 run tp @s ~ ~-1.55 ~
execute if score #tep_face kitpvp.game matches 1 run tp @s ~ ~-0.9 ~
execute if score #tep_face kitpvp.game matches 2 run tp @s ~ ~-2.0 ~

# 第三步：记下进门时的下落深度（决定弹多远），一次弹出
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
scoreboard players set @s kitpvp.tep_step 0
execute at @s run function kitpvp:skill/enderman/launch
