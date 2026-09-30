# ===== 战士：发出"补给"这一份金苹果 =====                                                                                    
 # 调用时机：                                                                                                                  
 #   1) kit/warrior.mcfunction —— 选出战士的那一刻                                                                             
 #   2) skill/warrior.mcfunction —— 40 秒冷却走完时                                                                            
 #                                                                                                                             
 # 上限 1 的保证方式变了：不再检查背包（因为统计方案里"吃完才会进冷却"，                                                       
 # 冷却期间不会补发），而是靠在冷却 + tag 上的互斥保证。                                                                       
                                                                                                                               
 give @s minecraft:golden_apple 1                                                                                              
 tag @s add kitpvp.skill_ready                                                                                                                                                                                          
                                                                                                                               
 title @s actionbar {"text":"补给：获得 1 个金苹果","color":"gold"}                                                            
 playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4