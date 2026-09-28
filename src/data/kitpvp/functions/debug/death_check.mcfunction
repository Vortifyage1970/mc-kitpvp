# /function kitpvp:debug/death_check                                                                                            
 # 逐项打印死亡链路相关状态                                                                                                      
                                                                                                                                 
 say ===== death chain =====                                                                                                     
                                                                                                                                 
 # 1. 大厅门：游戏内不该有 in_lobby                                                                                              
 execute as @a[tag=kitpvp.in_lobby] run say [门] 仍带 in_lobby，死亡会被拦                                                       
 execute as @a[tag=!kitpvp.in_lobby] run say [门] 无 in_lobby（游戏内正常）                                                      
                                                                                                                                 
 # 2. 免死门                                                                                                                     
 execute as @a[tag=kitpvp.death_immune] run say [门] 带 death_immune，不扣命                                                     
                                                                                                                                 
 # 3. 游戏模式                                                                                                                   
 execute as @a[gamemode=survival] run say [模式] survival                                                                        
 execute as @a[gamemode=adventure] run say [模式] adventure                                                                      
 execute as @a[gamemode=spectator] run say [模式] spectator                                                                      
                                                                                                                                 
 # 4. 死亡检测指针（两个数应同时存在，正常时两者相等）
execute as @a run scoreboard players add @s kitpvp.death_detect 0                                                                           
 execute as @a run scoreboard players get @s kitpvp.death_detect                                                                 
 execute as @a run scoreboard players get @s kitpvp.death_seen                                                                   
                                                                                                                                 
 # 5. 分数                                                                                                                       
 execute as @a run scoreboard players get @s kitpvp.lives                                                                        
 execute as @a run scoreboard players get @s kitpvp.deaths                                                                       
 scoreboard players get #global kitpvp.timer                                                                       