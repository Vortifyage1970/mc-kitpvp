# 开始一局游戏
                                                                                                                                  
 # 退出主大厅（清 in_lobby tag）                                                                                                 
 execute as @a run function kitpvp:lobby/exit
  # 标记"一局进行中"（胜负判定与结算只在此状态下生效）                                                                            
 scoreboard players set #state kitpvp.game 1                                                                                     
 # TODO: 人数 < 2 时应阻断开局，目前仅设计，未实现       
  # TODO: 等 map/random 实现后打开                                                                                                
 # function kitpvp:map/random                                                                                                    
 # function kitpvp:map/distribute                                                                                                
                                                                        