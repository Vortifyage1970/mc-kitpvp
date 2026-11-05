# 地球·31 交警（闪现版）：出场方式与另外两个交警一致 —— 坐无敌矿车出场、磁石头头、双手末地烛；**没有速度加成**（作者要求去掉），移动只靠两条腿 + 闪现
# 唯一的区别是机制：谁跑得比 v 快就瞬移到谁脸前（矿车 10 秒撤掉之后才开始闪，坐车时闪会把乘客从车上扯下来）
# 速度分由 skill/earth/cop_blink_track 每刻算好（格/刻 x100），判定与闪现都在 skill/earth/cop_blink_jaunt
# 阈值 v 写在 cop_blink_jaunt 的 scores={kitpvp.pspd=900..} 里：900 = (0.30 格/刻)²，平地疾跑 784 不触发，疾跑跳 1225 才触发
# 车的倒计时沿用 earth_cop_cart（tick 里那条 kill 直接复用），车上的 200 刻与下面僵尸自己的 1 刻冷却互不干扰
summon minecraft:minecart ~ ~ ~ {Tags:["kitpvp.earth_mount","kitpvp.earth_cop_cart"],Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cop_blink"],CustomName:'{"text":"交警","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:end_rod",Count:1b},{id:"minecraft:end_rod",Count:1b}],ArmorItems:[{},{},{},{id:"minecraft:lodestone",Count:1b}]}]}
scoreboard players set @e[tag=kitpvp.earth_cop_cart] kitpvp.earth_cd_a 200
scoreboard players set @e[tag=kitpvp.earth_cop_blink] kitpvp.earth_cd_a 1
