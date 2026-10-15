# 一次性发回举盾令牌，随后关窗（give_egg 幂等，手上还有就不叠加）
function kitpvp:skill/tank/give_egg

tag @s remove kitpvp.tank_handout

title @s actionbar {"text":"举盾已就绪","color":"aqua"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
