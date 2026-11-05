# 地球·52 集合者：出场的一瞬间把 50 格内所有地球生灵（含其它召唤物）拉到自己脚边
# 只发生一次：不挂 tick、不挂计时器 —— 它是个"一次性集结信号"，不是持续光环
# 用 spreadplayers 而不是 tp 到同一点：1~4 格内散开，避免几十只叠成一摞互相窒息、也避免碰撞箱把彼此挤飞
# 头是钟（召集的意象），主手山羊角（吹号），本体僵尸 20 血；打人还是 3 点基础伤害，手上东西纯装饰
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_gatherer"],CustomName:'{"text":"集合者","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:goat_horn",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:bell",Count:1b}],Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}
# 集结：排除自己（它刚生成在 ~ ~ ~，没必要再散一次），50 格内所有带 earth_minion 的一起拉过来
execute at @s run spreadplayers ~ ~ 1 4 false @e[tag=kitpvp.earth_minion,tag=!kitpvp.earth_gatherer,distance=..50]
# 一声集合钟：给附近的人一个听觉提示（20 格内）
playsound minecraft:block.bell.resonate master @a[distance=..20] ~ ~ ~ 1.0 0.8
