# 被动「辞锋」：命中任意实体时判定（advancement player_hurt_entity 驱动，先撤销再判定）
advancement revoke @s only kitpvp:player/zhuzhiwu_hit
execute if score @s kitpvp.kit matches 97 run function kitpvp:skill/zhuzhiwu/hit_roll
