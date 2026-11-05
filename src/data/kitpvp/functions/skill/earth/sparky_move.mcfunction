# @s = 电磁炮：向目标缓慢滚动（0.05 格/刻 ≈ 1 格/秒），慢到可以直接走位躲开
# 保留 NoAI：它不挥爪、不追人，位移完全由这两行 tp 决定 —— 炮台不该近战
# 第一行只转向（tp 到原地 + facing entity），第二行才迈步；三步方块检查防"把自己 tp 进墙里窒息"
# 劫掠兽 2.2 高、横截面大，所以脚部（0.8）、腰部（1.2）、头顶（2.4）三个高度都要是空气
execute at @s facing entity @p[distance=..15,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] feet run tp @s ~ ~ ~
# 4~12 格才迈步：太近就不动，免得用身体把玩家顶进方块；最近的那个人恰好是召唤者时也不动
execute if entity @p[distance=4..15,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @p[distance=4..15,sort=nearest] kitpvp.etid = #spk_owner kitpvp.game if block ^ ^ ^0.8 minecraft:air if block ^ ^1.2 ^0.8 minecraft:air if block ^ ^2.4 ^0.8 minecraft:air run tp @s ^ ^ ^0.05
