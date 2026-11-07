# @s = 挨了打的讲解石：立刻离场，并刷一条"像真玩家退服"的系统消息
# 用 translate 而不是手写文本：multiplayer.player.left 就是原版玩家退出的那条（黄色），
# 玩家看到的字面等于 "讲解石 离开了游戏"，一眼分不出是召唤物还是真人
# 先挪走再 kill：直接 kill 会播僵尸倒地那一套死亡动画，像"被打死"而不是"退服"；
# 挪到世界底下再标记死亡，动画和死亡音效都在几百格之外，玩家这边只看到它凭空消失
tellraw @a {"translate":"multiplayer.player.left","with":[{"text":"讲解石"}],"color":"yellow"}
particle minecraft:poof ~ ~0.9 ~ 0.35 0.7 0.35 0.01 10
tp @s ~ -100 ~
kill @s
