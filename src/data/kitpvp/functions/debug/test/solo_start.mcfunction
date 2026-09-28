# ===== 单人开局（测试模式专用）=====                                                                                           
 # 前提：必须已开测试模式（#test=1），否则 1 名幸存者会被判定获胜                                                                
 # 只做"让玩家进入可游玩状态"的最小集合；不传送（地图坐标 TODO）                                                                 
                                                                                                                                 
 # 前置检查：未开测试模式则拦下                                                                                                  
 execute if score #test kitpvp.game matches 0 run title @s times 5 40 10                                                         
 execute if score #test kitpvp.game matches 0 run title @s title {"text":"请先开启测试模式","color":"red","bold":true}           
 execute if score #test kitpvp.game matches 0 run tellraw @s [{"text":"[测试] 先执行 /function kitpvp:debug/test/on","color":"red"}]                                                                                           
                                                                                                                                 
 # --- 以下仅测试模式开启时执行 ---                                                                                              
 # 1) 挂 selected（否则 survivors 统计不到、虚空兜底不生效）                                                                     
 execute if score #test kitpvp.game matches 1 as @s run tag @s add kitpvp.selected                                               
                                                                                                                                 
 # 2) 摘 spectator，切生存                                                                                                       
 execute if score #test kitpvp.game matches 1 as @s run tag @s remove kitpvp.spectator                                           
 execute if score #test kitpvp.game matches 1 as @s run gamemode survival @s                                                     
                                                                                                                                 
 # 3) 命数 / 存活复位                                                                                                            
 execute if score #test kitpvp.game matches 1 as @s run scoreboard players set @s kitpvp.lives 3                                 
 execute if score #test kitpvp.game matches 1 as @s run scoreboard players set @s kitpvp.alive 1                                 
                                                                                                                                 
 # 4) 退出大厅                                                                                                                   
 execute if score #test kitpvp.game matches 1 as @s run function kitpvp:lobby/exit                                               
                                                                                                                                 
 # 5) 标记一局进行中                                                                                                             
 execute if score #test kitpvp.game matches 1 run scoreboard players set #state kitpvp.game 1                                    
                                                                                                                                 
 # 6) 5 秒无敌                                                                                                                   
 execute if score #test kitpvp.game matches 1 as @s run function kitpvp:player/invincible                                        
                                                                                                                                 
 # 7) 提示                                                                                                                       
 execute if score #test kitpvp.game matches 1 run title @a times 5 30 10                                                         
 execute if score #test kitpvp.game matches 1 run title @a title {"text":"[测试] 开局","color":"light_purple","bold":true}       
 execute if score #test kitpvp.game matches 1 run title @a subtitle {"text":"记得先选职业","color":"gray"}                       
                                                                                                                                 
 # TODO: 传送（地图坐标待定，否则玩家留在原地）                                                                                  
 # execute if score #test kitpvp.game matches 1 as @s run tp @s <x> <y> <z>                          