# 由 turret_hit 在冷却就绪时调用（@s = 攻击者，位置已在攻击者身上）
# 先置冷却再回血：同一刻若判定到多次，第二次数到的冷却已经不是 0，不会连回
scoreboard players set @s kitpvp.turret_heal_cd 20

# 1.20.1 判不出"打的是哪一个"，按近身取最近的自家炮台
# 生命恢复对亡灵无效（LivingEntity#canBeAffected 直接拒掉），改用瞬伤 —— 亡灵吃瞬伤是回血
execute at @s as @e[tag=kitpvp.turret,distance=..4,sort=nearest,limit=1] if score @s kitpvp.turret_owner = #ttid kitpvp.game run effect give @s minecraft:instant_damage 1 0 true
