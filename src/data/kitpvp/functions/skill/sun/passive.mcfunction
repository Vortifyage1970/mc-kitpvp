# 免疫一切状态效果：每刻清空自己身上的效果，连自己的增益也一起清（设计如此，见 04 §十二）。
# 只在游戏进行中清：结算期封锁给的抗性 V（game/end）与大厅的饱和不能被清掉，否则结算期间会被打死 / 大厅掉饱食。
execute if score #state kitpvp.game matches 1 run effect clear @s

# 无敌期的保护同样是抗性 V（player/invincible），会被上面一并清掉 ⇒ 按剩余无敌刻数补回 1 秒。
# 补的是 1 秒而不是 5 秒：清效果每刻都在跑，1 秒足够接上；余下的 1 秒由 player/end_invincible 收掉。
execute if score @s kitpvp.inv matches 1.. run effect give @s minecraft:resistance 1 4 true
