 # ===== 强制结束（走正常 10 秒结算流程）=====                                                                                   
 # 用途：单人测试时手动触发"结算 → 10 秒 → reset"完整流程                                                                        
 # 注意：#survivors 会被重算，用于决定 end 里是"胜利"还是"平局"分支                                                              
                                                                                                                                 
 # 先刷新 survivors（供 end 的宣布使用）                                                                                         
 scoreboard players set #survivors kitpvp.game 0                                                                                 
 execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run scoreboard players add #survivors kitpvp.game 1                                                                                                                               
                                                                                                                                 
 # 直接进入结算                                                                                                                  
 function kitpvp:game/end                          