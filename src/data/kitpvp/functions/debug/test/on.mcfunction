# ===== 开启测试模式 =====                                                                                                      
# 效果：check_winner 不再自动结算，单人可正常测试，开启命令输出反馈                                                                               
# 用法：/function kitpvp:debug/test/on                                                                                          
 gamerule sendCommandFeedback true                                                                                                                                
 scoreboard players set #test kitpvp.game 1                                                                                      
                                                                                                                                 
say ===== 测试模式 已开启 =====                                                                                                 
 tellraw @a [{"text":"[测试模式]","color":"light_purple","bold":true},{"text":"已开启。单人开局不会自动判胜。","color":"white"}] 
 tellraw @a [{"text":"▶ solo_start","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/solo_start"},"hoverEvent":{"action":"show_text","contents":"单人开始一局"}}]                                  
 tellraw @a [{"text":"▶ force_end","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/force_end"},"hoverEvent":{"action":"show_text","contents":"立刻结算（走 10 秒流程）"}}]                       
 tellraw @a [{"text":"▶ force_reset","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/force_reset"},"hoverEvent":{"action":"show_text","contents":"立刻重置（不等 10 秒）"}}]                       
 tellraw @a [{"text":"▶ build","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/build"},"hoverEvent":{"action":"show_text","contents":"建造模式（创造+退出游戏统计）"}}]                      
 tellraw @a [{"text":"▶ play","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/play"},"hoverEvent":{"action":"show_text","contents":"游玩模式（生存+参与游戏统计）"}}]                       
 tellraw @a [{"text":"▶ status","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/status"},"hoverEvent":{"action":"show_text","contents":"打印测试状态"}}]        
 tellraw @a [{"text":"▶ music","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/music"},"hoverEvent":{"action":"show_text","contents":"放点轻松音乐"}}]                              
 tellraw @a [{"text":"▶ off","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/test/off"},"hoverEvent":{"action":"show_text","contents":"关闭测试模式"}}]             