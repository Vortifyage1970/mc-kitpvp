# 地球魂石落地（执行位置 = 魂石落点，@s = 使用者）
# 让使用者也占一个地球队槽：不是地球职业也能进，队槽只用于"召唤物不攻击自己"
function kitpvp:skill/earth/link

# 落点插一个隐形标记：每 0.5 秒（10 刻）召一只随机生灵，共 4 只（40 刻），到点自己清掉
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_earth_marker","kitpvp.soul_earth_new"]}
scoreboard players operation @e[tag=kitpvp.soul_earth_new] kitpvp.earth_owner = @s kitpvp.etid
scoreboard players set @e[tag=kitpvp.soul_earth_new] kitpvp.earth_life 40
scoreboard players set @e[tag=kitpvp.soul_earth_new] kitpvp.earth_cd_a 0
tag @e[tag=kitpvp.soul_earth_new] remove kitpvp.soul_earth_new

title @s actionbar {"text":"魂石·万物：4 只生灵将在此集结（2 秒）","color":"blue"}
playsound minecraft:block.grass.place master @s ~ ~ ~ 0.8 0.8
