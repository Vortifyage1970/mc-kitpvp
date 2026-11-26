# 斩杀线：命中玩家 → 目标中毒 II 6 秒；24 刻（1.2 秒）内置冷却防连点刷毒
# advancement 只给到攻击者、拿不到受击者，所以目标由 poison_hit 用"临时 tag 排除自己 + 3 格扫描"找
# 只在主手是淬毒短匕时生效：空手 / 捡来的武器不给被动
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.poisoner_hit_cd matches ..0 if data entity @s SelectedItem.tag.KitPoisonerBlade run function kitpvp:skill/poisoner/poison_hit
