# 地球魂石：首行推进快照（villager 蛋只在本魂石里发，不会和别的职业共用）
scoreboard players operation @s kitpvp.soul_earth_last = @s kitpvp.soul_earth_used

# ⚠ 必须写成 `at @s at @e[...]` 两段：tick 里是 `as @a ... run function` 进来的，执行位置还在世界出生点，
#   单写 `execute at @e[...distance=..8]` 时那个 distance 是拿出生点量的，永远选不到脚边的载体（见 02 §八）
# 先把自己定位到使用者，再选他 8 格内那只「地球魂石」，最后以载体的位置调用
execute at @s at @e[type=minecraft:villager,name="地球魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/earth_apply

execute at @s run kill @e[type=minecraft:villager,name="地球魂石"]
