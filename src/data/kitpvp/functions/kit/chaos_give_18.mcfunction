tag @s remove kitpvp.chaos_hand
execute unless data entity @s SelectedItem run tag @s add kitpvp.chaos_hand
execute if entity @s[tag=kitpvp.chaos_hand] run item replace entity @s weapon.mainhand with minecraft:crafting_table{ChaosBlade:1b,ChaosId:18b,ChaosUses:3b,ChaosMelee:1b,display:{Lore:['{"text": "无数悲叹的灵魂徘徊在其掌心。", "color": "dark_purple", "italic": false}','{"text": "无法带来乐趣之人会被回收。", "color": "dark_purple", "italic": false}']},Enchantments:[{id:"minecraft:sharpness",lvl:3s}]} 1
execute unless entity @s[tag=kitpvp.chaos_hand] run give @s minecraft:crafting_table{ChaosBlade:1b,ChaosId:18b,ChaosUses:3b,ChaosMelee:1b,display:{Lore:['{"text": "无数悲叹的灵魂徘徊在其掌心。", "color": "dark_purple", "italic": false}','{"text": "无法带来乐趣之人会被回收。", "color": "dark_purple", "italic": false}']},Enchantments:[{id:"minecraft:sharpness",lvl:3s}]} 1
tag @s remove kitpvp.chaos_hand
scoreboard players set @s kitpvp.chaos_uses 3
