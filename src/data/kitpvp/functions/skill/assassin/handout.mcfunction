# 一次性发回隐匿令牌，随后关窗（give_item 幂等，手上还有就不叠加）
function kitpvp:skill/assassin/give_item

tag @s remove kitpvp.assassin_handout

title @s actionbar {"text":"隐匿已就绪","color":"dark_purple"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
