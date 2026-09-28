# ===== 游玩模式 =====                                                                                                          
 # 用途：从建造模式切回，开始测试职业功能                                                                                        
 # 语义：生存模式 + 参与游戏统计（挂 selected）                                                                                  
 # 注意：不会自动给职业，玩家需自行选职业后再测      
 # 仅用于单人测试，不进行最终结算                                                                            
                                                                                                                                 
 # 参与游戏统计                                                                                                                  
 tag @s add kitpvp.selected                                                                                                      
                                                                                                                                 
 # 摘掉游戏状态标签                                                                                                              
 tag @s remove kitpvp.spectator                                                                                                  
 tag @s remove kitpvp.in_lobby                                                                                                   
 tag @s remove kitpvp.respawn_pending                                                                                            
                                                                                                                                 
 # 命数 / 存活复位                                                                                                               
 scoreboard players set @s kitpvp.lives 3                                                                                        
 scoreboard players set @s kitpvp.alive 1                                                                                        
 scoreboard players set @s kitpvp.inv 0                                                                                          
                                                                                                                                 
 # 生存                                                                                                                          
 gamemode survival @s                                                                                                            
 clear @s                                                                                                                        
 effect clear @s                                                                                                                 
                                                                                                                                 
 # 5 秒无敌，防止刚切换就被打死                                                                                                  
 function kitpvp:player/invincible                                                                                               
                                                                                                                                 
 # 提示                                                                                                                          
 title @s times 5 30 10                                                                                                          
 title @s title {"text":"游玩模式","color":"green","bold":true}                                                                  
 title @s subtitle {"text":"请先选职业","color":"gray"}               