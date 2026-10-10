# ===== 随机职业：经典（表） =====
# 调用：/function kitpvp:kit/random（classic.mcfunction 的 [随机] 按钮）
# @s = 点随机的玩家
#
# 池：经典（表）已实装职业，且编号必须连续。
#     当前 = 1 战士 / 2 弓箭手 / 3 坦克 / 4 刺客 / 5 纵火狂
#     幽灵、渔夫未实装（无 kit/info/ghost、kit/info/fisher），不进池。
#
# 随机数生成：1.20.1 没有 /random 命令。
#   用 predicate kitpvp:random/1in2（chance 0.5）连掷 7 次，拼出 0..127 的均匀随机数。
#   只依赖这一个 predicate 文件，函数行数固定，不随职业数量增长。
#   ⚠ 前提：同一 tick 内多次评估同一 predicate 必须是独立掷骰（未实测，见文末）。
#
# 取模：128 不是池大小的整数倍，理论上有 <1% 的偏向，对选职业无感。
#
# 池大小与起始编号每次重设：新增职业时只改这两行的数字。

scoreboard players set #pool_size kitpvp.game 5
scoreboard players set #pool_base kitpvp.game 1

scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64

scoreboard players operation @s kitpvp.rng %= #pool_size kitpvp.game
scoreboard players operation @s kitpvp.rng += #pool_base kitpvp.game
scoreboard players operation @s kitpvp.kit = @s kitpvp.rng

# 转交"确认选择"链路。
# 若你的"确认选择"公共逻辑已集中在 util/give_kit，上面这一行就够；
# 若不是，改成下面这组按编号分派（每加一个职业补一行）。
function kitpvp:util/give_kit

# execute if score @s kitpvp.kit matches 1 run function kitpvp:kit/warrior
# execute if score @s kitpvp.kit matches 2 run function kitpvp:kit/archer
# execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank
# execute if score @s kitpvp.kit matches 4 run function kitpvp:kit/assassin
# execute if score @s kitpvp.kit matches 5 run function kitpvp:kit/arsonist
