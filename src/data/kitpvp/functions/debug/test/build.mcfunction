# ===== 建造模式 =====                                                                                                          
 # 用途：造地图、摆测试场地、调试地图机关                                                                                        
 # 语义：创造模式 + 退出游戏统计（摘 selected），不参与 survivors、不触发虚空兜底                                                
 # 恢复：用 /function kitpvp:debug/test/play                                                                                     
                                                                                                                                 
 # 退出游戏统计（避免被 tick 的虚空兜底 kill）                                                                                   
 tag @s remove kitpvp.selected                                                                                                   
                                                                                                                                 
 # 摘掉游戏状态标签                                                                                                              
 tag @s remove kitpvp.spectator                                                                                                  
 tag @s remove kitpvp.respawn_pending                                                                                            
 tag @s remove kitpvp.invincible                                                                                                 
                                                                                                                                 
 # 清负面效果（防施工被卡 / 减速）                                                                                               
 effect clear @s                                                                                                                 
                                                                                                                                 
 # 回满血（1.20.1 无 /heal，用瞬加血代替；amplifier 5 = 6*4=24 颗心，足够）                                                      
 effect give @s minecraft:instant_health 1 5 true                                                                                
                                                                                                                                 
 # 创造模式                                                                                                                      
 gamemode creative @s                                                                                                            
                                                                                                                                 
 # 提示                                                                                                                          
 title @s times 5 30 10                                                                                                          
 title @s title {"text":"建造模式","color":"light_purple","bold":true}                                                           
 title @s subtitle {"text":"创造 / 已退出游戏统计","color":"gray"}                 