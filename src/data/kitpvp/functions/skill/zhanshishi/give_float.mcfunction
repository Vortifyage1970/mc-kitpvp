# 发 1 个「漂浮陷阱」：把布陷阱者的 trap_id 烙进物品，用来区分「自己捡回」与「别人捡走」
execute if score @s kitpvp.trap_id matches 1 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:1b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 2 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:2b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 3 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:3b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 4 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:4b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 5 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:5b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
execute if score @s kitpvp.trap_id matches 6 run give @s minecraft:quartz{KitTrap:1b,KitTrapFloat:1b,KitTrapOwner:6b,display:{Name:'{"text":"漂浮陷阱","color":"aqua","italic":false}'}} 1
