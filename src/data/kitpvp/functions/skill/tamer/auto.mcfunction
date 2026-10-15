# 自动补货：真狼蛋不足 3 个就补 1 个并罚 30 秒节流。放狼是原版行为，没有使用侧逻辑，也不碰 cd（见 03 §2.13）
# 数量用 clear ... 0 读背包真实值：计数器会漂移（见 04 §八）
# tick 调 dispatch 时执行位置在世界出生点，凡用到 ~ 的都要自己 at @s 锚定
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:wolf_spawn_egg{KitTamerEgg:1b} 0

execute if score @s kitpvp.tmp matches ..2 run function kitpvp:skill/tamer/give_egg
execute if score @s kitpvp.tmp matches ..2 run scoreboard players set @s kitpvp.cd 600
execute if score @s kitpvp.tmp matches ..2 run title @s actionbar {"text":"补给：+1 狼蛋","color":"green"}
execute if score @s kitpvp.tmp matches ..2 at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4
