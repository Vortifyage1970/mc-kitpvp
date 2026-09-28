# ===== 关闭测试模式 =====                                                                                                      
 # 关闭后自动结算立即恢复：若当前 #state=1 且幸存者只剩 1 人，                                                                   
 # 下一次 tick 轮询（最多 20 刻内）就会触发 game/end。                                                                           
                                                                                                                                 
 scoreboard players set #test kitpvp.game 0                                                                                      
                                                                                                                                 
 say ===== 测试模式 已关闭 =====                                                                                                 
 tellraw @a [{"text":"[测试模式] ","color":"light_purple","bold":true},{"text":"已关闭，自动结算恢复。","color":"white"}]       