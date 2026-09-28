# 结束一局游戏
 # ===== 结束一局游戏（结算入口） =====                                                                                          
 # 由 kitpvp:game/check_winner 在"仅剩 1 名幸存者"时调用                                                                         
 # 职责：锁定状态 → 宣布胜利者 → 延迟 10 秒 → 交给 kitpvp:game/reset
 # `..0` 与 `2..` 分支仅供手动调用 `end` 时使用，自动路径恒为 `matches 1`                                                             
                                                                                                                                 
 # --- 一、锁定状态：改为"结算中"，此后 check_winner 不再触发 ---                                                                
 # （同一 objective 下 #state 与 #survivors 是两个不同的假玩家名，不冲突）                                                       
 scoreboard players set #state kitpvp.game 2                                                                                     
                                                                                                                                 
 # --- 二、宣布胜利者 ---                                                                                                        
 execute if score #survivors kitpvp.game matches 1 run title @a times 10 60 20                                                   
 execute if score #survivors kitpvp.game matches 1 run title @a title {"text":"游戏结束","color":"gold","bold":true}             
 execute if score #survivors kitpvp.game matches 1 run title @a subtitle [{"text":"胜者：","color":"yellow"},{"selector":"@a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator]","color":"white","bold":true}]                                                                                                              
 execute if score #survivors kitpvp.game matches 1 run tellraw @a [{"text":"[胜利]","color":"gold","bold":true},{"selector":"@a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator]","color":"yellow"},{"text":" 赢了！","color":"yellow"}]                                                                                 
 execute if score #survivors kitpvp.game matches 1 as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1                                                             
                                                                                                                                 
 # 无人生还的兜底提示（不会进入胜利分支，但仍走 10 秒后重置）                                                                    
 execute if score #survivors kitpvp.game matches ..0 run tellraw @a [{"text":"[平局]","color":"gray","bold":true},{"text":"本局无幸存者","color":"gray"}]
  # 中途强制结束（survivors >= 2）                                                                                                
 execute if score #survivors kitpvp.game matches 2.. run tellraw @a [{"text":"[结束]","color":"red","bold":true},{"text":"本局被管理员终止","color":"gray"}]                                                           
                                                                                                                                 
 # --- 三、结算期间的封锁（待定，暂不启用） ---                                                                                  
 # TODO: 结算期"禁止再交战"的实现方式未定（设计文档第九节：抗性 V or 屏蔽伤害）                                                  
 # 骨架：execute as @a run function kitpvp:player/invincible   ← 需要先定方案再打开                                              
                                                                                                                                 
 # --- 四、等待 10 秒后清理重置 ---                                                                                              
 # 200 刻 = 10 秒；replace 模式保证重复调用不会叠加多个定时任务                                                                  
 schedule function kitpvp:game/reset 200t replace                                                                                
                                                   