# 一次性发回隐匿令牌，随后关窗（窗口由 skill/assassin/cast 打开：令牌真的被用掉才开）。
# give_item 本身是幂等的（背包里还有就不给），所以"地上捡回一个"不会叠加（见 04 §四）
function kitpvp:skill/assassin/give_item

tag @s remove kitpvp.assassin_handout

title @s actionbar {"text":"隐匿已就绪（令牌已发回）","color":"dark_purple"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
