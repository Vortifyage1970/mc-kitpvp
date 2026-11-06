# @s = 挨了打的讲解石：立刻离场，并刷一条"像真玩家退服"的系统消息
# 用 translate 而不是手写文本：multiplayer.player.left 就是原版玩家退出的那条（黄色），
# 玩家看到的字面等于 "讲解石 离开了游戏"，一眼分不出是召唤物还是真人
tellraw @a {"translate":"multiplayer.player.left","with":[{"text":"讲解石"}],"color":"yellow"}
particle minecraft:poof ~ ~1 ~ 0.3 0.4 0.3 0.02 10
kill @s
