tellraw @a [{"text":"═══ 低空飞行器自检 ═══","color":"gold","bold":true}]
scoreboard players set #lfc kitpvp.game 0
scoreboard players set #lfb kitpvp.game 0
execute as @e[tag=kitpvp.earth_lowflyer_carrier] run scoreboard players add #lfc kitpvp.game 1
execute as @e[tag=kitpvp.earth_lowflyer_body] run scoreboard players add #lfb kitpvp.game 1
tellraw @a [{"text":"蝙蝠 = ","color":"gray"},{"score":{"name":"#lfc","objective":"kitpvp.game"},"color":"white"},{"text":"   吊舱骷髅 = ","color":"gray"},{"score":{"name":"#lfb","objective":"kitpvp.game"},"color":"white"}]
# 吊舱的射击冷却：40 → 0 每 2 秒射一发；如果一直是 40，说明 tick 没在递减
scoreboard players set #lfcd kitpvp.game -1
execute as @e[tag=kitpvp.earth_lowflyer_body,limit=1,sort=nearest] run scoreboard players operation #lfcd kitpvp.game = @s kitpvp.earth_cd_a
tellraw @a [{"text":"吊舱冷却 earth_cd_a = ","color":"gray"},{"score":{"name":"#lfcd","objective":"kitpvp.game"},"color":"white"},{"text":"（-1 = 场上没有吊舱）","color":"dark_gray"}]
# 从吊舱脚下量 16 格，按 lowflyer_shoot 的口径数一遍"它会打谁"
scoreboard players set #lfv kitpvp.game 0
execute as @e[tag=kitpvp.earth_lowflyer_body,limit=1,sort=nearest] at @s run execute as @a[distance=..16,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.lf_summoner matches 1 run scoreboard players add #lfv kitpvp.game 1
tellraw @a [{"text":"16 格内可射击的人 = ","color":"gray"},{"score":{"name":"#lfv","objective":"kitpvp.game"},"color":"white"},{"text":"（创造/旁观/召唤者都不算）","color":"dark_gray"}]
# 最近那个人的 etid / lf_summoner，和吊舱自己的 earth_owner（三者对上 = 你是召唤者，不会被射）
execute as @e[tag=kitpvp.earth_lowflyer_body,limit=1,sort=nearest] at @s run tellraw @a [{"text":"你 etid = ","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.etid"},"color":"white"},{"text":"  你的 lf_summoner = ","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.lf_summoner"},"color":"white"},{"text":"  吊舱 earth_owner = ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_owner"},"color":"white"}]
