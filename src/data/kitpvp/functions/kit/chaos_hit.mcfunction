# 打到人（advancement 触发）：只对近战类武器计数
advancement revoke @s only kitpvp:player/chaos_hit
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosMelee run function kitpvp:kit/chaos_use
