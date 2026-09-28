 # ===== 胜负判定 =====                                                                                                          
 # 触发时机：                                                                                                                    
 #   1) kitpvp:player/eliminate 末尾                                                                                             
 #   2) kitpvp:tick 的 20 刻兜底轮询                                                                                             
 # 职责：只做"统计 + 判定"，真正的结算在 kitpvp:game/end                                                                         
 #                                                                                                                               
 # 测试模式（#test=1）下：只做统计，不自动结算。                                                                                 
 # 防止单人测试时"一开局 survivors=1 就立刻判胜"，由玩家手动调                                                                   
 # kitpvp:debug/test/force_end 或 force_reset 结束。                                                                             
                                                                                                                                 
 # --- 一、统计"已选职业且非旁观且非旁观模式"的玩家数 → #survivors ---                                                           
 scoreboard players set #survivors kitpvp.game 0                                                                                 
 execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run scoreboard players add #survivors kitpvp.game 1                                                                                                                               
                                                                                                                                 
 # --- 二、判定（仅非测试模式）---                                                                                               
 # 条件：非测试模式 + 一局进行中 + 有且仅有 1 名幸存者                                                                           
 # 0 人不自动结算，避免全员掉线时误判平局并清场（设计文档第九节）                                                                
 execute if score #test kitpvp.game matches 0 if score #state kitpvp.game matches 1 if score #survivors kitpvp.game matches 1 run function kitpvp:game/end              