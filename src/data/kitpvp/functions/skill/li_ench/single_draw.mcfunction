# 单抽：冷却 2 秒；3 点瞬间伤害换一次抽卡
execute if score @s kitpvp.li_single_cd matches 1.. run title @s actionbar [{"text":"单抽冷却：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.li_single_cd"}},{"text":" 刻","color":"gray"}]
execute if score @s kitpvp.li_single_cd matches ..0 run scoreboard players set @s kitpvp.li_single_cd 40
execute if score @s kitpvp.li_single_cd matches 40 run damage @s 3 minecraft:magic
execute if score @s kitpvp.li_single_cd matches 40 run function kitpvp:skill/li_ench/pull
