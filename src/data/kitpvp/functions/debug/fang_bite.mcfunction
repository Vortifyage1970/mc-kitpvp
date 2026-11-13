# 真正咬下去：尖牙只做视觉，伤害自己结算
# ⚠ 原版尖牙的 6 点伤害写死在代码里，NBT 没有改伤害的键；把 Warmup 拉长想"只摆姿势"会让它整个隐身
#    （渲染跟蓄力进度绑在一起），所以改成：真尖牙照常蓄力咬合，但把它们摆在离你 2 格以外 —— 咬不到你，
#    伤害由 fang_hit 自己给。三只沿"骷髅 → 你"的方向排开，正是原版唤魔者那条牙线的样子
execute at @e[tag=kitpvp.fang_at] facing entity @e[tag=kitpvp.fang_test,limit=1] feet positioned ^ ^ ^2 run summon minecraft:evoker_fangs ~ ~ ~ {Warmup:8,Tags:["kitpvp.fang_line"]}
execute at @e[tag=kitpvp.fang_at] facing entity @e[tag=kitpvp.fang_test,limit=1] feet positioned ^ ^ ^3 run summon minecraft:evoker_fangs ~ ~ ~ {Warmup:8,Tags:["kitpvp.fang_line"]}
execute at @e[tag=kitpvp.fang_at] facing entity @e[tag=kitpvp.fang_test,limit=1] feet positioned ^ ^ ^4 run summon minecraft:evoker_fangs ~ ~ ~ {Warmup:8,Tags:["kitpvp.fang_line"]}
execute at @e[tag=kitpvp.fang_at] run particle minecraft:crit ~ ~0.2 ~ 0.3 0.1 0.3 0.05 20
execute at @e[tag=kitpvp.fang_at] run playsound minecraft:entity.evoker.cast_spell hostile @a[distance=..16] ~ ~ ~ 1 1.1
schedule function kitpvp:debug/fang_hit 8t replace
schedule function kitpvp:debug/fang_clean 40t replace
