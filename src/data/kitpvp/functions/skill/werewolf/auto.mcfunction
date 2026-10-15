# 自动补货：真令牌不足 2 个就补 1 个并罚 40 秒节流。cd 只在这里与 skill/werewolf/fire 写（见 03 §2.13）
# 数量必须用 clear ... 0 读背包真实值，自制计数器会漂移（见 04 §八）
# tick 调 dispatch 时执行位置在世界出生点，凡用到 ~ 的都要自己 at @s 锚定
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:wolf_spawn_egg{KitWerewolfEgg:1b} 0

execute if score @s kitpvp.tmp matches ..1 run function kitpvp:skill/werewolf/give_egg
execute if score @s kitpvp.tmp matches ..1 run scoreboard players set @s kitpvp.cd 800
execute if score @s kitpvp.tmp matches ..1 run title @s actionbar {"text":"补给：+1 嗅闻令牌","color":"gray"}
execute if score @s kitpvp.tmp matches ..1 at @s run playsound minecraft:entity.wolf.pant master @s ~ ~ ~ 0.7 1.2
