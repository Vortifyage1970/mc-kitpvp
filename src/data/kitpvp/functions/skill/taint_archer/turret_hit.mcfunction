# 由 advancement kitpvp:player/taint_archer_hit_turret 触发（@s = 攻击者）
# 1.20.1 判不出"打的是哪一个"，按近身取最近的自家炮台
# 生命恢复对亡灵无效（LivingEntity#canBeAffected 直接拒掉），改用瞬伤 —— 亡灵吃瞬伤是回血
execute if score @s kitpvp.kit matches 24 if data entity @s SelectedItem.tag.KitTaintAxe run scoreboard players operation #ttid kitpvp.game = @s kitpvp.ttid

execute if score @s kitpvp.kit matches 24 if data entity @s SelectedItem.tag.KitTaintAxe as @e[tag=kitpvp.turret,distance=..4,sort=nearest,limit=1] if score @s kitpvp.turret_owner = #ttid kitpvp.game run effect give @s minecraft:instant_damage 1 0 true


advancement revoke @s only kitpvp:player/taint_archer_hit_turret
