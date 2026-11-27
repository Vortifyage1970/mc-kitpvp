# 主手拿着《神学大全》：减速 30% + 闪烁发光 + 音效与粒子 + 两条进度合计 40 秒涨 1 级（满级就停）
effect give @s minecraft:slowness 1 1 true
# 读书计时：既当"闪烁相位"，也当"补格节拍"
scoreboard players add @s kitpvp.ench_book_t 1
# 闪烁发光：80 刻一个周期（4 秒），前 40 刻亮、后 40 刻灭 —— 每 2 秒亮 2 秒
scoreboard players operation #book_ph kitpvp.game = @s kitpvp.ench_book_t
scoreboard players operation #book_ph kitpvp.game %= #book_eighty kitpvp.game
execute if score #book_ph kitpvp.game matches ..39 run effect give @s minecraft:glowing 2 0 true
# 蓄力：每刻 1 格 + 每 8 刻再补 1 格 = 每刻 9/8 格 ⇒ 800 刻（40 秒）正好 900 格 = 3 点 = 1 级
execute if score @s kitpvp.ench_sword matches ..10 if score @s kitpvp.ench_sw matches ..2 run scoreboard players add @s kitpvp.ench_sw_fill 1
execute if score @s kitpvp.ench_armor matches ..10 if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 1
scoreboard players operation #book_p8 kitpvp.game = @s kitpvp.ench_book_t
scoreboard players operation #book_p8 kitpvp.game %= #ench_eight kitpvp.game
execute if score #book_p8 kitpvp.game matches 0 if score @s kitpvp.ench_sword matches ..10 if score @s kitpvp.ench_sw matches ..2 run scoreboard players add @s kitpvp.ench_sw_fill 1
execute if score #book_p8 kitpvp.game matches 0 if score @s kitpvp.ench_armor matches ..10 if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 1
execute if score @s kitpvp.ench_sw matches ..2 if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.ench_ap matches ..2 if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
function kitpvp:skill/enchanter/book_fx
scoreboard players add @s kitpvp.ench_book_cd 1
execute if score @s kitpvp.ench_book_cd matches 40.. run function kitpvp:skill/enchanter/book_page
