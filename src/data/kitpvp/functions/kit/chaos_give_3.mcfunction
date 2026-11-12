execute unless data entity @s SelectedItem run item replace entity @s weapon.mainhand with minecraft:bow{ChaosBlade:1b,ChaosId:3b,ChaosUses:3b,ChaosBow:1b,Damage:379s,display:{Lore:['{"text": "瞬息万变的世界不会容许片刻犹豫。", "color": "dark_purple", "italic": false}','{"text": "拉弓搭箭的那刻，他们曾想过真正属于他们的战场会是这样的吗？", "color": "dark_purple", "italic": false}']}} 1
execute if data entity @s SelectedItem run give @s minecraft:bow{ChaosBlade:1b,ChaosId:3b,ChaosUses:3b,ChaosBow:1b,Damage:379s,display:{Lore:['{"text": "瞬息万变的世界不会容许片刻犹豫。", "color": "dark_purple", "italic": false}','{"text": "拉弓搭箭的那刻，他们曾想过真正属于他们的战场会是这样的吗？", "color": "dark_purple", "italic": false}']}} 1
scoreboard players set @s kitpvp.chaos_uses 3
give @s minecraft:arrow 3
