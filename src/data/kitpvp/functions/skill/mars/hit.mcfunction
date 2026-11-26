# 命中回调（advancement player_hurt_entity）：只有手持诅咒剑才计数
advancement revoke @s only kitpvp:player/mars_hit
execute if data entity @s SelectedItem.tag.KitMarsSword run function kitpvp:skill/mars/target
