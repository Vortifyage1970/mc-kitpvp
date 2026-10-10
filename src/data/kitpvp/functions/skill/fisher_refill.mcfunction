# ===== 渔夫：技能补戟（给戟 + 进冷却 + 提示） =====
# 调用方：skill/fisher_fire
#         调用条件已保证"玩家当前不持有带 KitFisherTrident 标记的三叉戟"，
#         所以本函数无条件给戟 + set cd，不必再判一次。
# @s = 渔夫
#
# ⚠ 下方三叉戟的 NBT 必须与 kit/fisher.mcfunction 里那把完全一致
#   （唯一差别是本函数用 give 进背包，kit 用 item replace 进主手）。
#   改任意一边都要同步另一边，否则"补一把相同的三叉戟"这条前提就破了。
#
# set cd 写在最后：冷却从"补戟一瞬间"开始，共 1200 刻（60 秒）。
# 先给物品再进冷却，保证"补发成功才罚冷却"。

give @s minecraft:trident{KitFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:loyalty",lvl:2}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;7,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;7,0,0,6],Slot:"mainhand"}]} 1

scoreboard players set @s kitpvp.cd 1200

title @s actionbar {"text":"寻回三叉戟（冷却 60 秒）","color":"blue"}
playsound minecraft:item.trident.return master @s ~ ~ ~ 0.8 1.0
