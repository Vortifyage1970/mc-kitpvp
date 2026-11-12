# 打到任何东西（advancement 触发，不再限定玩家）：只对近战类武器计数
# 2026-11-12：原来 advancement 只认 player，大厅里只有装饰盔甲架可打，于是永远不计数，看起来像不换武器
advancement revoke @s only kitpvp:player/chaos_hit
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosMelee run function kitpvp:kit/chaos_use
