# 一次性发回举盾令牌，随后关窗（窗口由 skill/tank/cast 打开：令牌真的被用掉才开）。
# give_egg 本身是幂等的（背包里还有就不给），所以"地上捡回一个"不会叠加（见 04 §四）
function kitpvp:skill/tank/give_egg

tag @s remove kitpvp.tank_handout

title @s actionbar {"text":"举盾已就绪（令牌已发回）","color":"aqua"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
