# 一次性发回寻戟令牌，随后关窗（give_egg 幂等，手上还有就不叠加）
function kitpvp:skill/fisher/give_egg

tag @s remove kitpvp.fisher_handout

title @s actionbar {"text":"寻回三叉戟已就绪","color":"blue"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
