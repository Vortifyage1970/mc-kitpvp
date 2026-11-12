# 备用触发：item_used_on_block（带 ChaosToken 标签的河豚蛋）
advancement revoke @s only kitpvp:player/chaos_skill_use
execute if score @s kitpvp.kit matches 45 run function kitpvp:kit/chaos_skill
