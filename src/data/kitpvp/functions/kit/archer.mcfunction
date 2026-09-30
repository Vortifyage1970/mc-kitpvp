# ===== 弓箭手 · 职业发放 =====                                                                                               
 # 调用方：                                                                                                                    
 #   1) kit/info/archer 的 [确认选择] 按钮 → /function kitpvp:kit/archer                                                       
 #   2) util/give_kit（重发装备）→ function kitpvp:kit/archer                                                                  
 # 责任：清场 → 写 kit 分 → 发装备 → 写命数 → 打 tag                                                                           
                                                                                                                               
 # 第一行清场（会清零 kitpvp.kit，本函数随后写回）                                                                             
 function kitpvp:util/clear_player                                                                                             
                                                                                                                               
 # 职业分（编号必须与 skill/dispatch、util/give_kit 保持一致）                                                                 
 scoreboard players set @s kitpvp.kit 2                                                                                        
                                                                                                                               
 # 命数                                                                                                                        
 scoreboard players set @s kitpvp.lives 3                                                                                      
                                                                                                                               
 # 护甲                                                                                                                        
 item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b} 1                                             
 item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b} 1                                        
 item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1                                              
 item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b} 1                                                 
                                                                                                                               
 # 主手石剑 / 副手带标记的弓                                                                                                   
 # KitBow:1b 是弓箭手换弹技能的识别标记，不要摘                                                                                
 item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b} 1                                           
 item replace entity @s weapon.offhand with minecraft:bow{KitBow:1b,Unbreakable:1b} 1                                          
                                                                                                                               
 # 消耗品                                                                                                                      
 give @s minecraft:cooked_beef 16                                                                                              
 give @s minecraft:arrow 12                                                                                                    
                                                                                                                               
 # 标记"已选职业"                                                                                                              
 tag @s add kitpvp.selected                                                                                                    
                                                                                                                               
 tellraw @s [{"text":"已选择：","color":"gray"},{"text":"弓箭手","color":"aqua","bold":true}]