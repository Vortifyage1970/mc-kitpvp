# 太阳魂石落地（执行位置 = 落点，@s = 使用者）
# 落点留一个 marker 当锚点：20 秒内每刻刷新失明（2 秒覆盖），中途进出范围的玩家都会立刻中招；
# 每 2 秒再给范围里的每个参战玩家灌一条噪音（128 选 1，复用太阳自己的噪音池）
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_sun_marker","kitpvp.soul_sun_new"]}
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_timer 400
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_next 1
tag @e[tag=kitpvp.soul_sun_new] remove kitpvp.soul_sun_new

title @s actionbar {"text":"魂石·日蚀：10 格内全体失明 20 秒，每 2 秒一条噪音","color":"gold"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.6
