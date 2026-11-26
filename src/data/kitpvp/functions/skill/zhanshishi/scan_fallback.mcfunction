# 兜底：每 2 刻看一眼「身上有没有陷阱物品」，只对真正带着的人做归属判定
# 事件判据（minecraft.picked_up）正常时这里等于重复检查一次，代价是每人 5 条 clear 计数
execute store result score @s kitpvp.tmp run clear @s minecraft:tripwire_hook{KitTrapHook:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/zhanshishi/check_hook
execute store result score @s kitpvp.tmp run clear @s minecraft:quartz{KitTrapFloat:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/zhanshishi/check_float
execute store result score @s kitpvp.tmp run clear @s minecraft:firework_star{KitTrapWorm:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/zhanshishi/check_worm
execute store result score @s kitpvp.tmp run clear @s minecraft:spider_eye{KitTrapPoison:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/zhanshishi/check_poison
execute store result score @s kitpvp.tmp run clear @s minecraft:poppy{KitTrapBoom:1b} 0
execute if score @s kitpvp.tmp matches 1.. run function kitpvp:skill/zhanshishi/check_boom
