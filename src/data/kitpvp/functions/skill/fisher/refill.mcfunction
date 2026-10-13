# 三叉戟 NBT 必须与 kit/fisher.mcfunction 的那把完全一致；set cd 在最后（补发成功才罚冷却）
give @s minecraft:trident{KitFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:loyalty",lvl:2}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;7,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;7,0,0,6],Slot:"mainhand"}]} 1

scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"寻回三叉戟（冷却 30 秒）","color":"blue"}
playsound minecraft:item.trident.return master @s ~ ~ ~ 0.8 1.0
