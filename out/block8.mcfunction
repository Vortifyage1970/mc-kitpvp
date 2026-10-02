# 收回大厅物品 + 摘准备状态（防止带进局内）
clear @a minecraft:carrot_on_a_stick{KitLobbyRod:1b}
clear @a minecraft:wooden_sword{KitLobbySword:1b}
tag @a remove kitpvp.ready
tag @a remove kitpvp.ready_pending
