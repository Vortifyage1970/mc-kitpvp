# 一条命令验证"绳子到底绑没绑"：跑 /function kitpvp:debug/betaturn_check
# 输出解读：① root UUID 与 tail1 Leash 应完全相同；② Leash 显示为空 = NBT 根本没被接受；③ 两者相同却没有绳 = 绑上了但没渲染
tellraw @a [{"text":"[β转角] 现存实体数：","color":"yellow"},{"score":{"name":"#bt_n","objective":"kitpvp.game"},"color":"white"}]
scoreboard players set #bt_n kitpvp.game 0
execute store result score #bt_n kitpvp.game if entity @e[tag=kitpvp.earth_polypeptide_betaturn]
tellraw @a [{"text":"  实体数 = ","color":"gray"},{"score":{"name":"#bt_n","objective":"kitpvp.game"},"color":"white"}]
tellraw @a [{"text":"  root UUID  = ","color":"gray"},{"nbt":"UUID","entity":"@e[tag=kitpvp.earth_polypeptide_betaturn_a,limit=1,sort=nearest]","color":"aqua"}]
tellraw @a [{"text":"  tail1 Leash= ","color":"gray"},{"nbt":"Leash","entity":"@e[tag=kitpvp.earth_polypeptide_betaturn_tail1,limit=1,sort=nearest]","color":"aqua"}]
tellraw @a [{"text":"  tail2 Leash= ","color":"gray"},{"nbt":"Leash","entity":"@e[tag=kitpvp.earth_polypeptide_betaturn_tail2,limit=1,sort=nearest]","color":"aqua"}]
tellraw @a [{"text":"= 两行一致且有绳 = 生效；Leash 空 = NBT 没被接受；一致但无绳 = 绑了没渲染","color":"dark_gray"}]
