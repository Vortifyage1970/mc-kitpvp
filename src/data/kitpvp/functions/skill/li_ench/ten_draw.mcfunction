# 十连：冷却 15 秒；20 点瞬间伤害换十次抽卡
execute if score @s kitpvp.li_ten_cd matches 1.. run title @s actionbar [{"text":"十连冷却：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.li_ten_cd"}},{"text":" 刻","color":"gray"}]
execute if score @s kitpvp.li_ten_cd matches ..0 run scoreboard players set @s kitpvp.li_ten_cd 100
execute if score @s kitpvp.li_ten_cd matches 100 run damage @s 20 minecraft:magic
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
execute if score @s kitpvp.li_ten_cd matches 100 run function kitpvp:skill/li_ench/pull
