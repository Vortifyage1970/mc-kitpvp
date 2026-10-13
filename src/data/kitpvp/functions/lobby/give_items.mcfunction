# 幂等发放大厅两件物品：钓竿 KitLobbyRod（右键切换准备）、大厅剑 KitLobbySword（+0.2 移速）。
# give 只填首个空槽，故由 tick 每刻兜底补发（背包被清后自动补回）。
# 1.20.1 旧版 NBT 写法：AttributeModifiers / Unbreakable / display.Name
execute if entity @s[tag=kitpvp.ready] unless data entity @s Inventory[{tag:{KitLobbyRod:1b}}] run give @s minecraft:carrot_on_a_stick{KitLobbyRod:1b,Unbreakable:1b,Enchantments:[{}],display:{Name:'{"text":"已准备","color":"gold","bold":true}'}} 1
execute unless entity @s[tag=kitpvp.ready] unless data entity @s Inventory[{tag:{KitLobbyRod:1b}}] run give @s minecraft:carrot_on_a_stick{KitLobbyRod:1b,Unbreakable:1b,display:{Name:'{"text":"准备","color":"green","bold":true}'}} 1

execute unless data entity @s Inventory[{tag:{KitLobbySword:1b}}] run give @s minecraft:stone_sword{KitLobbySword:1b,Unbreakable:1b,display:{Name:'{"text":"大厅剑","color":"gray","italic":false}'},AttributeModifiers:[{AttributeName:"minecraft:generic.movement_speed",Name:"kitpvp.lobby_speed",Amount:0.2,Operation:0,UUID:[I;1,2,3,4],Slot:"mainhand"}]} 1
