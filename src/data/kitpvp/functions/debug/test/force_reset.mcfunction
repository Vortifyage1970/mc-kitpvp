 # ===== 立刻重置（跳过 10 秒等待）=====                                                                                         
 # 用途：不想等 10 秒，立刻回到"空闲"状态                                                                                        
 # 会取消可能已排队的一次 reset，再立刻执行一次，避免重复触发                                                                    
                                                                                                                                 
 schedule clear kitpvp:game/reset                                                                                                
 function kitpvp:game/reset   