# 地球魂石落地（执行位置 = 魂石落点，@s = 使用者）
# 先认出使用者当前在哪套队：绝不换他的队（他是幽灵/里·驯兽师/里·弓箭手时，换队会让他的召唤物变成敌人）
function kitpvp:skill/soul/earth_team_id

# 落点插一个隐形标记：每 0.5 秒（10 刻）召一只随机生灵，共 4 只（40 刻），到点自己清掉
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_earth_marker","kitpvp.soul_earth_new"]}
scoreboard players operation @e[tag=kitpvp.soul_earth_new] kitpvp.soul_earth_team = #steam kitpvp.game
scoreboard players set @e[tag=kitpvp.soul_earth_new] kitpvp.earth_life 40
scoreboard players set @e[tag=kitpvp.soul_earth_new] kitpvp.earth_cd_a 0
tag @e[tag=kitpvp.soul_earth_new] remove kitpvp.soul_earth_new

title @s actionbar {"text":"魂石·万物：4 只生灵将在此集结（2 秒）","color":"blue"}
playsound minecraft:block.grass.place master @s ~ ~ ~ 0.8 0.8
