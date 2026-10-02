# ===== 退出主大厅 =====
# 触发时机：玩家准备进入一局游戏时

# 核心：清除"在大厅"标记
tag @s remove kitpvp.in_lobby
# 退出大厅：摘准备状态 + 收回大厅物品，避免带进局内                                                                                    
tag @s remove kitpvp.ready                                                                                                             
tag @s remove kitpvp.ready_pending                                                                                                     
clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}                                                                                         
clear @s minecraft:stone_sword{KitLobbySword:1b}

# --- 退出大厅的准备动作（由 game/start 承担）---
# 传送、切生存、发装备等不在本文件处理