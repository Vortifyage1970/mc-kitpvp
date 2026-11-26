# 漂浮陷阱：每跳跃 25 次补 1 个，**无上限**（原版是凑满 25 次给 1 个并归零）
scoreboard players operation #trap_d kitpvp.game = @s kitpvp.trap_jump_used
scoreboard players operation #trap_d kitpvp.game -= @s kitpvp.trap_float_last
execute if score #trap_d kitpvp.game matches 25.. run function kitpvp:skill/zhanshishi/give_float
execute if score #trap_d kitpvp.game matches 25.. run scoreboard players add @s kitpvp.trap_float_last 25
execute if score #trap_d kitpvp.game matches 25.. run title @s actionbar {"text":"补给：漂浮陷阱","color":"aqua"}
