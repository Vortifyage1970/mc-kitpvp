# 真伤害：尖牙咬合那一刻（8 刻后）落在你身上 2 点魔法伤害（1 颗心）。想削/加就改这个 2
execute at @e[tag=kitpvp.fang_at] as @e[type=minecraft:player,distance=..1.6,gamemode=!spectator] run damage @s 2 minecraft:magic by @e[tag=kitpvp.fang_test,limit=1]
# 骷髅已经死了（by 选不到施法者）就退化成无来源伤害，别让这一发白放
execute at @e[tag=kitpvp.fang_at] unless entity @e[tag=kitpvp.fang_test] as @e[type=minecraft:player,distance=..1.6,gamemode=!spectator] run damage @s 2 minecraft:magic
execute at @e[tag=kitpvp.fang_at] run particle minecraft:crit ~ ~1 ~ 0.3 0.4 0.3 0.05 12
