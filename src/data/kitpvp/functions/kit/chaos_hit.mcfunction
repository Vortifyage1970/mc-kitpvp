# 打到人（advancement 触发）：只对近战类武器计数
advancement revoke @s only kitpvp:player/chaos_hit
# 诅咒剑：先判定（chaos_use 可能在第五次命中时就换掉手里的武器）
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosCurse run function kitpvp:skill/mars/target
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosMelee run function kitpvp:kit/chaos_use
