tag @s remove kitpvp.molten_core
scoreboard players set @s kitpvp.molten_core_timer 0

# 到自己炮台的形态计时归零为止，它们都会各自复原；这里立刻收一次，避免视觉上多留一拍
scoreboard players operation #ttid kitpvp.game = @s kitpvp.ttid

execute as @e[tag=kitpvp.turret_molten] if score @s kitpvp.turret_owner = #ttid kitpvp.game run function kitpvp:skill/taint_archer/turret_from_molten
