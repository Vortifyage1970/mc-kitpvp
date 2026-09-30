# 每游戏刻执行                                                                                                                
 # 玩家接入检测：未登记的玩家 → 走 join 流程                                                                                   
 execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join                                                             
                                                                                                                               
 # 冷却递减                                                                                                                    
 execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1                                            
 execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1

 # ===== 战士金苹果消耗检测 =====                                                                                              
 # 统计 objective：吃掉金苹果的瞬间 used 自动 +1                                                                               
 # 本刻 used 比 last 大 → 刚吃掉，转交 warrior_consume                                                                         
 # 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖                                                                      
 execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] if score @s kitpvp.gapple_used > @s kitpvp.gapple_last run function kitpvp:skill/warrior_consume                                          

 # ===== 弓箭手：清除落地的箭 =====
# 弓箭手射出的箭一落地（inGround:1b）就清除，
# 防止"射出去 → 换弹 → 再捡回来"把箭数刷过 12 支上限。
# 副作用：会一并清掉其它来源（如骷髅）落地的箭。
kill @e[type=minecraft:arrow,nbt={inGround:1b}]

 # ===== 职业技能结算（统一入口）=====                                                                                         
 # 只筛"有职业、活着、主技能冷却归零"的玩家，转交 dispatch；                                                                   
 # 具体哪个职业发什么，由 skill/dispatch 按 kitpvp.kit 分派。                                                                  
 # 新增职业请改 skill/dispatch，不要在这里加行。                                                                               
 execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch    
                                                                                                                               
 # 兼容中途加入的玩家：没有 inv 分数就补 0                                                                                     
 scoreboard players add @a kitpvp.inv 0                                                                                        
                                                                                                                               
 # 无敌倒计时（每刻 -1）                                                                                                       
 execute as @a[scores={kitpvp.inv=1..}] run scoreboard players remove @s kitpvp.inv 1                                          
                                                                                                                               
 # 无敌结束                                                                                                                    
 execute as @a[tag=kitpvp.invincible,scores={kitpvp.inv=0}] run function kitpvp:player/end_invincible                          
                                                                                                                               
 # 虚空兜底：Y < -74 直接判死（阈值可调）                                                                                      
 # y=-1024 配合 dy=950 覆盖 y ∈ [-1024, -74]                                                                                   
 execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world         
                                                                                                                               
 # 死亡检测                                                                                                                    
 execute as @a[tag=!kitpvp.spectator] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch                
                                                                                                                               
 # 重生后处理（由 on_death 打 tag，本 tick 消费）                                                                              
 execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] run function kitpvp:player/after_death                                              
                                                                                                                               
 # ===== 胜负兜底轮询（每 20 刻一次）=====                                                                                     
 # 覆盖"玩家中途退出服务器导致幸存者减少，但没人触发 eliminate"的情况                                                          
 scoreboard players add #tick kitpvp.game 1                                                                                    
 execute if score #tick kitpvp.game matches 20.. run scoreboard players set #tick kitpvp.game 0                                
 execute if score #tick kitpvp.game matches 0 if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner    