# 汉堡小子蓄力（每刻，由 tick/burger 对 kit=89 存活玩家调用）
# 按住 Shift 时 +1，松手暂停并保留进度；上限 1000 = 50 秒
execute if predicate kitpvp:sneaking run scoreboard players add @s kitpvp.burger_charge 1
execute if score @s kitpvp.burger_charge matches 1001.. run scoreboard players set @s kitpvp.burger_charge 1000

# 每满 1 秒一声提示音：只在蓄力中走计时器，松手不响也不重置
execute if predicate kitpvp:sneaking run scoreboard players remove @s kitpvp.burger_snd 1
execute if score @s kitpvp.burger_snd matches ..0 if predicate kitpvp:sneaking run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.7 1.2
execute if score @s kitpvp.burger_snd matches ..0 run scoreboard players set @s kitpvp.burger_snd 20

# 蓄到 25 秒（500）全场提示一次；回落到 500 以下后允许再次提示
execute if score @s kitpvp.burger_charge matches 500.. if score @s kitpvp.burger_announced matches 0 run function kitpvp:skill/burger/announce
execute if score @s kitpvp.burger_charge matches ..499 run scoreboard players set @s kitpvp.burger_announced 0

# 蓄满 50 秒：召唤汉堡兽并清零重来
execute if score @s kitpvp.burger_charge matches 1000.. run function kitpvp:skill/burger/summon
