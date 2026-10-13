execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/sudden_drop
execute if score #state kitpvp.game matches 1 as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=kitpvp.sudden_death] run function kitpvp:skill/soul/give
execute if score #state kitpvp.game matches 1 run schedule function kitpvp:game/sudden_drop 600t replace
