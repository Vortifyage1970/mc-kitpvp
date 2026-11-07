# @s = 点了"取消准备"的那个玩家（只在"结束准备"那 5 秒里出现）
# 取消 = 这一轮不结算：不挨伤害、也不夸；只在 mob_ready=0（还没点过、也没结算过）时响应
execute if score @s kitpvp.mob_ready matches 0 run tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray","italic":true},{"text":"你取消了准备。","color":"yellow","italic":true}]
# 取消成功：一声软木琴，比"你真棒"低一档
execute if score @s kitpvp.mob_ready matches 0 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.8 0.9
# 山羊角（sound.3 = 思角）：和"动员"那声用同一族的角，但换一个音，听得出是"撤"而不是"集合"
execute if score @s kitpvp.mob_ready matches 0 run playsound minecraft:item.goat_horn.sound.3 master @s ~ ~ ~ 0.9 0.85
# ★ 置 1 必须放在所有 if matches 0 的判定之后：先置 1 会让上面三条全部失败（以前那个木琴就是这么哑掉的）
execute if score @s kitpvp.mob_ready matches 0 run scoreboard players set @s kitpvp.mob_ready 1
