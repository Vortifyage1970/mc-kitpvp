# 附魔师自检：两条蓄力 / 两级等级 / 手持物
execute as @p run tellraw @a [{"text":"[附魔师] 剑蓄力=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_sw"}},{"text":" 剑等级=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_sword"}},{"text":" 甲蓄力=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_ap"}},{"text":" 甲等级=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_armor"}}]
execute as @p run tellraw @a [{"text":"[附魔师] 手上一格=","color":"gray"},{"nbt":"SelectedItem.id","entity":"@p","color":"white"}]
