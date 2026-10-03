# ===== 魂石·刺客：传送到最近的其它玩家，速度 II + 隐身 I，持续 20 秒 =====
tag @s add kitpvp.soul_given

effect give @s minecraft:speed 20 1 true
effect give @s minecraft:invisibility 20 0 true

# 传送到最近的其它玩家：
#   1. 先给自己打 kitpvp.soul_tp_src，用它把自己从"候选目标"里排除
#   2. at @s             → 以自己为原点排序
#   3. as @a[sort=nearest,limit=1] → 选出最近的其它玩家，执行者换成他
#   4. at @s             → 执行位置换成目标玩家的位置
#   5. tp 带 src 标记的玩家到 ~ ~ ~ → 自己落到目标玩家位置
# 没有其它玩家时 as 为空，tp 不触发，只保留效果，不会报错
tag @s add kitpvp.soul_tp_src
execute at @s as @a[tag=!kitpvp.soul_tp_src,tag=!kitpvp.spectator,sort=nearest,limit=1] at @s run tp @a[tag=kitpvp.soul_tp_src,limit=1] ~ ~ ~
tag @s remove kitpvp.soul_tp_src

title @s actionbar {"text":"魂石·暗袭：速度 II + 隐身 I（20 秒）","color":"dark_purple"}
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.4
