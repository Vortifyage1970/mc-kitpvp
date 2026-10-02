# ===== 主大厅：发放大厅专用物品 =====
# 调用方：lobby/enter
# @s = 刚进入主大厅的玩家
#
# 两件物品：
#   hotbar.0（第 1 快捷栏）：准备钓竿，右键切换准备状态
#   hotbar.8（第 9 快捷栏）：大厅剑，仅提供 +0.1 移动速度
#
# 用 item replace 而不是 give：保证永远落在指定槽位，
# 重复进入大厅时也不会在背包里堆出第二把。
# 副作用：会顶掉玩家放在 hotbar.0 / hotbar.8 上的其它物品。
# 大厅里本来就只有这两件东西，可以接受。
#
# ⚠ 检测用的统计 objective 绑定的是 minecraft:fishing_rod。
#   钓鱼竿抛竿/收杆都会在 FishingRodItem#use 内部无条件 awardStat，
#   所以右键一定被记到。胡萝卜钓竿没有这个行为，不要换回去。

# 准备钓竿：已准备时发带附魔光效的版本，未准备时发普通版
# Enchantments:[{}] 是 1.20.1 的"只发光、不显示附魔名"写法。
# 若 /give 报错，改成 Enchantments:[{id:"minecraft:unbreaking",lvl:1}],HideFlags:1
execute if entity @s[tag=kitpvp.ready] run item replace entity @s hotbar.0 with minecraft:fishing_rod{KitLobbyRod:1b,Unbreakable:1b,Enchantments:[{}],display:{Name:'{"text":"已准备","color":"gold","bold":true}'}}
execute unless entity @s[tag=kitpvp.ready] run item replace entity @s hotbar.0 with minecraft:fishing_rod{KitLobbyRod:1b,Unbreakable:1b,display:{Name:'{"text":"准备","color":"green","bold":true}'}}

# 大厅剑：+0.1 移动速度
# AttributeModifiers 是 1.20.1 旧版 NBT 格式（1.20.5+ 的 attribute_modifiers 不要写）
#   Operation:0   = 加法（add）
#   Slot:"mainhand" = 只在主手生效
#   UUID          = 本 modifier 的唯一标识，不要与其它 modifier 重复
item replace entity @s hotbar.8 with minecraft:wooden_sword{KitLobbySword:1b,Unbreakable:1b,display:{Name:'{"text":"大厅剑","color":"gray","italic":false}'},AttributeModifiers:[{AttributeName:"minecraft:generic.movement_speed",Name:"kitpvp.lobby_speed",Amount:0.1,Operation:0,UUID:[I;1,2,3,4],Slot:"mainhand"}]}
