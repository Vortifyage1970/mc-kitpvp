# @s = 打了队长的玩家（advancement: player/captain_shield 触发）。只有队长正举着盾才反伤
advancement revoke @s only kitpvp:player/captain_shield
# 1 点反伤，伤害来源记在队长身上（所以击杀会算给队长）
execute if entity @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6] run damage @s 1 minecraft:thorns by @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1]
# 盾被砸到的反馈：音效 + 火花（位置取队长，不是玩家，这样你能看见自己砍在盾上）
execute at @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1] run playsound minecraft:item.shield.block hostile @a[distance=..12] ~ ~ ~ 1 1.4
execute at @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1] run particle minecraft:crit ~ ~1 ~ 0.3 0.3 0.3 0.05 6
