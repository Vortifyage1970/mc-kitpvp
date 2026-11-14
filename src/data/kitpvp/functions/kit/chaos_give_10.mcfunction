tag @s remove kitpvp.chaos_hand
execute unless data entity @s SelectedItem run tag @s add kitpvp.chaos_hand
execute if entity @s[tag=kitpvp.chaos_hand] run item replace entity @s weapon.mainhand with minecraft:crossbow{ChaosBlade:1b,ChaosId:10b,ChaosUses:1b,ChaosXbow:1b,Damage:462s,display:{Name:'{"text": "大型手炮", "color": "dark_purple", "italic": false}',Lore:['{"text": "“人人为我......下一句是什么来着？”", "color": "dark_purple", "italic": false}']},Enchantments:[{id:"minecraft:multishot",lvl:1s}]} 1
execute unless entity @s[tag=kitpvp.chaos_hand] run give @s minecraft:crossbow{ChaosBlade:1b,ChaosId:10b,ChaosUses:1b,ChaosXbow:1b,Damage:462s,display:{Name:'{"text": "大型手炮", "color": "dark_purple", "italic": false}',Lore:['{"text": "“人人为我......下一句是什么来着？”", "color": "dark_purple", "italic": false}']},Enchantments:[{id:"minecraft:multishot",lvl:1s}]} 1
tag @s remove kitpvp.chaos_hand
scoreboard players set @s kitpvp.chaos_uses 1
give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1
