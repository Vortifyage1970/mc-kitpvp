# 三段伤害对照：每段间隔 15 刻（避开受击无敌帧），依次试三种写法
# 用法：/function kitpvp:debug/damage_probe —— 看哪一段掉了血，就知道哪种写法在你这儿有效
tellraw @a [{"text":"[测试 1/3] generic 无来源 2 点 —— 立刻","color":"gold"}]
execute as @a run damage @s 2 minecraft:generic
schedule function kitpvp:debug/damage_probe_2 15t replace
