# 重生后确认自己的鹦鹉还在：被炸死 / 落在没加载的区块里就补一只
# 命数耗尽变旁观不会走 after_death，所以这里天然就是"直到命数耗尽才停"
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
scoreboard players set #pparrot kitpvp.game 0
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run scoreboard players set #pparrot kitpvp.game 1
# 只有局中才允许补：大厅里 respawn 只清计数，不生成（唯一生成点是开局 enter_map）
execute if score #state kitpvp.game matches 1 if score #pparrot kitpvp.game matches 0 at @s run function kitpvp:skill/pluto/spawn
scoreboard players set @s kitpvp.parrot_miss 0
