# ===== 多伦多：矿车按钮（advancement 之外的第二道判定：看按钮 powered 状态） =====
execute if score #cart_cd1 kitpvp.game matches 1.. run scoreboard players remove #cart_cd1 kitpvp.game 1
execute if score #cart_cd2 kitpvp.game matches 1.. run scoreboard players remove #cart_cd2 kitpvp.game 1
execute if score #cart_cd3 kitpvp.game matches 1.. run scoreboard players remove #cart_cd3 kitpvp.game 1
execute if score #cart_cd4 kitpvp.game matches 1.. run scoreboard players remove #cart_cd4 kitpvp.game 1
execute if score #cart_cd5 kitpvp.game matches 1.. run scoreboard players remove #cart_cd5 kitpvp.game 1
execute if score #cart_cd6 kitpvp.game matches 1.. run scoreboard players remove #cart_cd6 kitpvp.game 1
execute if score #cart_cd7 kitpvp.game matches 1.. run scoreboard players remove #cart_cd7 kitpvp.game 1
execute if score #cart_cd8 kitpvp.game matches 1.. run scoreboard players remove #cart_cd8 kitpvp.game 1
execute if score #cart_cd9 kitpvp.game matches 1.. run scoreboard players remove #cart_cd9 kitpvp.game 1
execute if score #cart_cd10 kitpvp.game matches 1.. run scoreboard players remove #cart_cd10 kitpvp.game 1
execute if score #cart_cd11 kitpvp.game matches 1.. run scoreboard players remove #cart_cd11 kitpvp.game 1

# ===== 火星（kit 70）：地鸣触发 + 巨人/生灵心跳 =====
function kitpvp:skill/mars/giant_tick

# ===== 混沌弓箭手（kit 46）：每射一箭 → 自动装填一支随机魔法箭 =====
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=46},tag=!kitpvp.spectator] if score @s kitpvp.archer_shot > @s kitpvp.archer_shot_last run function kitpvp:skill/chaos_archer/cast

# ===== 哈雷彗星（kit 69）：补货 / 天堂制造 / 温度升高 / 近身加速 =====
execute as @a[scores={kitpvp.kit=69}] if score @s kitpvp.halley_cd matches 1.. run scoreboard players remove @s kitpvp.halley_cd 1
execute as @a[scores={kitpvp.kit=69,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/halley/heat
execute as @a[scores={kitpvp.kit=69,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/halley/near
