# ===== 刺客：隐匿 =====
# 调用：skill/assassin_cast（玩家右键令牌，cd 归零时）
# @s = 刺客
#
# 冷却从"技能释放一瞬间"开始：
#   set cd 600 是本函数的最后一步，从这里开始连续 30 秒
#   前 100 刻（5 秒）隐身 + 速度 III；后 500 刻纯冷却
#   cd 数到 ..500 时由 tick 触发 skill/assassin_unhide 恢复永久速度 I
#
# ⚠ 速度 III(amp 2) 会顶掉刺客的永久速度 I(amp 0)。
#   Minecraft 中"更高等级的同一效果"会替换低等级效果，而不是叠加。
#   所以 5 秒后速度 I 不会自动回来，必须由 assassin_unhide 补挂。

effect give @s minecraft:invisibility 5 0 true
effect give @s minecraft:speed 5 2 true

tag @s add kitpvp.assassin_hidden
scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"隐匿：5 秒隐身 + 速度 III","color":"dark_purple"}
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.4
