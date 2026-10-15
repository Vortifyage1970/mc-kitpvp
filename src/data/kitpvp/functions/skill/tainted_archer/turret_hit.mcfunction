# 由 advancement kitpvp:player/tainted_archer_hit_turret 触发（@s = 攻击者）
# 被动：用主武器石斧击打自家炮台给它回血；1 秒冷却（20 刻，石斧攻速 1.3/秒，正好卡住连点）
execute if score @s kitpvp.kit matches 24 if data entity @s SelectedItem.tag.KitTaintedAxe run scoreboard players operation #ttid kitpvp.game = @s kitpvp.ttid

execute if score @s kitpvp.turret_heal_cd matches ..0 if score @s kitpvp.kit matches 24 if data entity @s SelectedItem.tag.KitTaintedAxe run function kitpvp:skill/tainted_archer/turret_heal

advancement revoke @s only kitpvp:player/tainted_archer_hit_turret
