# 武器损坏：清主手、播损坏音、立刻发下一把（无缝）
playsound minecraft:entity.item.break master @s ~ ~ ~ 1.0 1.0
item replace entity @s weapon.mainhand with minecraft:air
function kitpvp:kit/chaos_next
