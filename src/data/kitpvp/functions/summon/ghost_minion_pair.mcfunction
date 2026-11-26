# @s = 使用者；执行位置/朝向 = 被攻击者（由上层 execute at @s as @a[...] 保留）
# ⚠ 本函数内不能再调 at @s，否则阴兵会出现在使用者身边而不是被攻击者身边
execute positioned ^1 ^ ^ run function kitpvp:summon/ghost_minion
execute positioned ^-1 ^ ^ run function kitpvp:summon/ghost_minion

# 队伍：主人已经在某套队里就绝不动他的队（换队会让他原有的炮台 / 阴兵 / 生灵 / 起义军翻脸）。
# 只有他一个队都没有（战士之类，或这局被 start_impl 清空过）才开一个幽灵槽，并把他 join 进去。
function kitpvp:util/team_index
execute if score #steam kitpvp.game matches 0 run scoreboard players add #ghost_tid kitpvp.game 1
execute if score #steam kitpvp.game matches 0 if score #ghost_tid kitpvp.game matches 7.. run scoreboard players set #ghost_tid kitpvp.game 1
execute if score #steam kitpvp.game matches 0 run scoreboard players operation @s kitpvp.tid = #ghost_tid kitpvp.game
execute if score #steam kitpvp.game matches 0 run scoreboard players operation #steam kitpvp.game = @s kitpvp.tid

# 主人落在幽灵那 6 个槽时才 join 他（本来就在同一个队时是空操作）
execute if score #steam kitpvp.game matches 1 run team join ghost_1 @s
execute if score #steam kitpvp.game matches 2 run team join ghost_2 @s
execute if score #steam kitpvp.game matches 3 run team join ghost_3 @s
execute if score #steam kitpvp.game matches 4 run team join ghost_4 @s
execute if score #steam kitpvp.game matches 5 run team join ghost_5 @s
execute if score #steam kitpvp.game matches 6 run team join ghost_6 @s

# 阴兵跟着同一个编号入队（util/team_join 按 tag kitpvp.team_new 找目标）
function kitpvp:util/team_join
tag @e remove kitpvp.ghost_minion_new

# 5 秒召唤冷却
scoreboard players set @s kitpvp.ghost_minion_cd 100

execute as @s run playsound minecraft:entity.warden.attack_impact master @a[distance=..9] ~ ~ ~ 0.8 1.2

title @s actionbar {"text":"阴兵已现（20 秒）","color":"dark_aqua"}
