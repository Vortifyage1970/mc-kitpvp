# 发 1 个「蠹虫陷阱」：把布陷阱者的 trap_id 烙进物品，用来区分「自己捡回」与「别人捡走」
execute if score @s kitpvp.trap_id matches 1 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:1b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 2 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:2b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 3 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:3b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 4 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:4b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 5 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:5b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 6 run give @s minecraft:firework_star{KitTrap:1b,KitTrapWorm:1b,KitTrapOwner:6b,display:{Name:'{"text":"蠹虫陷阱","color":"gold","italic":false}'}} 1
