# 可疑草丛的贴身判定（tick 按玩家逐个调，@s = 玩家、执行位置 = 玩家）
# 只有"主人以外的人"站进半径 1 格才算被惊动；主人自己踩上去不炸，可以顶着它走
# 队伍没法在命令里互相比较，所以草丛身上记了 earth_owner（= 主人的 etid），这里拿玩家的 etid 去比
scoreboard players operation #gowner kitpvp.game = @s kitpvp.etid

# 草丛没记归属（理论上不会有）时分数读 0，任何玩家都会把它踩爆，这是想要的方向
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped,scores={kitpvp.earth_grass_arm=..0},distance=..1] unless score @s kitpvp.earth_owner = #gowner kitpvp.game at @s run function kitpvp:summon/earth_grass_pop
