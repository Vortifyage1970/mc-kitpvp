# ===== 主大厅：发放 / 补发大厅专用物品 =====
# 调用方：
#   lobby/enter               （进大厅时立即发一份）
#   lobby/ready_on/ready_off  （切换准备状态时刷新钓竿）
#   tick.mcfunction           （每刻兜底：在大厅里但缺物品就补）
#
# 用 give + 幂等检测：
#   give 只往"首个空槽"塞，不保证 hotbar.0 / hotbar.8。
#   换来的是——玩家选职业触发 clear_player 清空背包后，
#   下一 tick 会自动补回两件大厅物品，不会卡在"手上没钓竿点不了"。
#
# 两件物品：
#   大厅钓竿   KitLobbyRod:1b   —— 右键切换准备状态
#              已准备版额外带 Enchantments:[{}]（仅发光、不显示附魔名）
#              幂等检测只按 KitLobbyRod:1b，两个版本都算"已有"
#   大厅剑     KitLobbySword:1b —— 仅提供 +0.1 移动速度
#
# 物品本体：minecraft:carrot_on_a_stick
#   未骑猪时右键不改耐久、不掉落、不生成任何实体，纯粹一个"开关信号"。
#   骑猪时右键会 hurtAndBreak(7)，但 Unbreakable:1b 挡住，不会坏；
#   那种情况下不产生 used 信号。大厅里不可能骑猪，忽略。

# 准备钓竿：按 ready tag 决定发哪一版，按 KitLobbyRod:1b 幂等
execute if entity @s[tag=kitpvp.ready] unless data entity @s Inventory[{tag:{KitLobbyRod:1b}}] run give @s minecraft:carrot_on_a_stick{KitLobbyRod:1b,Unbreakable:1b,Enchantments:[{}],display:{Name:'{"text":"已准备","color":"gold","bold":true}'}} 1
execute unless entity @s[tag=kitpvp.ready] unless data entity @s Inventory[{tag:{KitLobbyRod:1b}}] run give @s minecraft:carrot_on_a_stick{KitLobbyRod:1b,Unbreakable:1b,display:{Name:'{"text":"准备","color":"green","bold":true}'}} 1

# 大厅剑：+0.1 移动速度
# AttributeModifiers 是 1.20.1 旧版 NBT 格式（不要写 1.20.5+ 的 attribute_modifiers）
#   Operation:0 = 加法；Slot:"mainhand" = 只在主手生效
#   UUID 是本 modifier 的私有不冲突标识
execute unless data entity @s Inventory[{tag:{KitLobbySword:1b}}] run give @s minecraft:stone_sword{KitLobbySword:1b,Unbreakable:1b,display:{Name:'{"text":"大厅剑","color":"gray","italic":false}'},AttributeModifiers:[{AttributeName:"minecraft:generic.movement_speed",Name:"kitpvp.lobby_speed",Amount:0.2,Operation:0,UUID:[I;1,2,3,4],Slot:"mainhand"}]} 1