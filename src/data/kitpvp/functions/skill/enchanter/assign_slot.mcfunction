# 给附魔师分一条专属 bossbar 槽（1..8）
# 用玩家自己的 etid 取模：etid 每人唯一，所以两名附魔师不会抢同一条，
# 死亡重选、掉线重连也会自动算回同一条，不需要"找空位"那种会残留旧槽的写法。
scoreboard players operation @s kitpvp.ench_slot = @s kitpvp.etid
scoreboard players operation @s kitpvp.ench_slot %= #ench_eight kitpvp.game
scoreboard players operation @s kitpvp.ench_slot += #ench_one kitpvp.game
