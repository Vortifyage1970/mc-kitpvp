# 由根 tick 检测到"新死亡"时调用                                                                                                
 # 先把已处理指针推到当前值，防止每刻重复触发；再交给 on_death                                                                   
 scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect                                                      
 function kitpvp:player/on_death           