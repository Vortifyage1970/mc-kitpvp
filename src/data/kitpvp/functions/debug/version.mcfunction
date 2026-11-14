# [测试] 打印数据包版本号与内容规模（发给别人时让对方跑这个，就知道装的是哪一版）
tellraw @a [{"text":"=== KitPvP 数据包版本 ===\n","color":"gold","bold":true},{"text":"版本号：","color":"yellow"},{"text":"v1.0.0","color":"white"},{"text":"（地球生灵 75 只，2026-11-14 构建）\n","color":"gray"}]
scoreboard players set #ver_pool kitpvp.game 0
execute store result score #ver_pool kitpvp.game run scoreboard players get #pool_size kitpvp.game
tellraw @a [{"text":"随机池大小：","color":"yellow"},{"score":{"name":"#ver_pool","objective":"kitpvp.game"},"color":"aqua"},{"text":" 只\n","color":"gray"}]
tellraw @a [{"text":"平台：","color":"yellow"},{"text":"Minecraft Java 1.20.1 · 纯数据包（pack_format 15）\n","color":"white"}]
tellraw @a [{"text":"自检：","color":"yellow"},{"text":"/function kitpvp:debug/selfcheck","color":"aqua"}]
