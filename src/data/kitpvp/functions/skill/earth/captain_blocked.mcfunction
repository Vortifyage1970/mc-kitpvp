# @s = 打了队长的玩家（advancement: player/captain_shield 触发）。只有队长正举着盾才反伤
advancement revoke @s only kitpvp:player/captain_shield
# 举着盾的那只队长归谁：先补零，免得 operation 找不到实体时留着上一只的主人
scoreboard players set #cb_owner kitpvp.game 0
scoreboard players operation #cb_owner kitpvp.game = @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1,sort=nearest] kitpvp.earth_owner
# 反伤 1 点，来源记在队长身上（击杀算队长的）。分两行是为了跳过召唤者本人：owner 0 = 手动召、认不出主人，那就人人都反伤
execute if entity @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6] unless score #cb_owner kitpvp.game matches 1.. run damage @s 1 minecraft:thorns by @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1,sort=nearest]
execute if entity @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6] if score #cb_owner kitpvp.game matches 1.. unless score @s kitpvp.etid = #cb_owner kitpvp.game run damage @s 1 minecraft:thorns by @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1,sort=nearest]
# 盾被砸到的反馈：音效（位置取队长，不是玩家，这样你能听出自己砍在盾上）
execute at @e[tag=kitpvp.earth_captain,tag=kitpvp.cap_block,distance=..6,limit=1,sort=nearest] run playsound minecraft:item.shield.block hostile @a[distance=..12] ~ ~ ~ 1 1.4
