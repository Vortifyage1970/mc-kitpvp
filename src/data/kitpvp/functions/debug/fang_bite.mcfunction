# 真正咬下去，分两层：视觉 + 自己结算的伤害
# ① 视觉：召一只"只摆姿势、永不咬合"的尖牙。原版尖牙的伤害写死在代码里（6 点，还随难度放大），
#    NBT 没有"改伤害"这一项，唯一可控的是 Warmup（蓄力刻数）：给个 200 刻，它一直停在蓄力阶段，
#    永远走不到咬人那一步，30 刻后由 fang_clean 收掉，玩家只看见尖牙冒出来
execute at @e[tag=kitpvp.fang_at] run summon minecraft:evoker_fangs ~ ~ ~ {Warmup:200,Tags:["kitpvp.fang_fake"]}
execute at @e[tag=kitpvp.fang_at] run particle minecraft:crit ~ ~0.2 ~ 0.3 0.1 0.3 0.05 20
execute at @e[tag=kitpvp.fang_at] run playsound minecraft:entity.evoker.cast_spell hostile @a[distance=..16] ~ ~ ~ 1 1.1
# ② 伤害：自己结算，1.3 格内 2 点魔法伤害。想削/加就改这个数字（2 点 = 1 颗心）
execute at @e[tag=kitpvp.fang_at] as @e[type=minecraft:player,distance=..1.3,gamemode=!spectator] run damage @s 2 minecraft:magic by @e[tag=kitpvp.fang_test,limit=1]
# 骷髅已经死了（by 选不到施法者）就退化成无来源伤害，别让这一发白放
execute at @e[tag=kitpvp.fang_at] unless entity @e[tag=kitpvp.fang_test] as @e[type=minecraft:player,distance=..1.3,gamemode=!spectator] run damage @s 2 minecraft:magic
kill @e[tag=kitpvp.fang_at]
schedule function kitpvp:debug/fang_clean 30t replace
