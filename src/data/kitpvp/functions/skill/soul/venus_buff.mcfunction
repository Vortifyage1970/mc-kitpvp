# 武装模块（速度 II / 力量 II / 跳跃提升 V）+ 制冷模块（10 格内非主人玩家缓慢 I）
# 每 0.5 秒续一次 1 秒时长：不会闪，也不会在主人身上留长尾
scoreboard players set @s kitpvp.soul_next 10
effect give @s minecraft:speed 1 1 true
effect give @s minecraft:strength 1 1 true
effect give @s minecraft:jump_boost 1 4 true
execute at @s as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.soul_venus_owner] run effect give @s minecraft:slowness 1 0 true
