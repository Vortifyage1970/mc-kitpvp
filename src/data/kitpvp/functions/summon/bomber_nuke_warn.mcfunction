# 核弹提示：所有玩家聊天栏黄字 + 一声远处的闷响（假核弹也走这条，提示一模一样才骗得过人）
tellraw @a [{"text":"核弹将在5秒后爆炸","color":"yellow"}]
execute as @a at @s run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 0.15 1.4
