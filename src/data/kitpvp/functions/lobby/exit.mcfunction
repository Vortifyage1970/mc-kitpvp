# 退出大厅：摘 in_lobby 与准备状态，收回大厅物品，避免带进局内
tag @s remove kitpvp.in_lobby
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending
clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}
clear @s minecraft:stone_sword{KitLobbySword:1b}
