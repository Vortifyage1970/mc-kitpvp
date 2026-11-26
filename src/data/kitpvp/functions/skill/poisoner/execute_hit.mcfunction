# @s = 目标玩家（血量 ≤ 3 颗心）：一击斩杀
# 击杀归属：最近手持淬毒短匕的攻击者（poison_hit 给攻击者挂了临时 tag kitpvp.poisoner_self）
damage @s 9999 minecraft:player_attack by @e[tag=kitpvp.poisoner_self,distance=..4,limit=1,sort=nearest]
playsound minecraft:entity.player.attack.crit master @s ~ ~ ~ 1 1
particle minecraft:crit ~ ~1 ~ 0.5 0.6 0.5 0.6 14
