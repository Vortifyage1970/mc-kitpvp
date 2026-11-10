# 地球·36 矿车（原味版）：蠹虫当坐骑、背上驮着一条橡木船；没有速度，只有虚弱 X
# 与 earth_minecart 是同一号出率的两半（各 50%），由 summon/earth_minecart_pick 掷骰决定召哪只
# 上下位：蠹虫是外层（主实体），船在 Passengers 里当乘客 —— 与交警 / 船夫正好相反，别抄反
# 船挂了三个标签：earth_mount（reset 统一清载具）、earth_minecart_boat（"这只矿车自己的船"）、earth_cart_boat（单独点名用）
# 船是"无法破坏"的：Invulnerable:1b 挡掉玩家/怪物对它的伤害；/kill 与 reset 里的按 tag 清除不受影响
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_minecart"],CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Passengers:[{id:"minecraft:boat",Type:"oak",Tags:["kitpvp.earth_mount","kitpvp.earth_minecart_boat","kitpvp.earth_cart_boat"],Invulnerable:1b,CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b}]}
effect give @e[tag=kitpvp.earth_minecart] minecraft:weakness infinite 9 true

# 45 秒（900 刻）后原地停住：只给刚召出的这一只埋倒计时（earth_minion_new 在 link 之后就没了）
scoreboard players set @e[tag=kitpvp.earth_minecart,tag=kitpvp.earth_minion_new] kitpvp.minecart_life 900

# 45 秒（900 刻）后原地停住：只给刚召出的这一只埋倒计时（earth_minion_new 在 link 之后就没了）
scoreboard players set @e[tag=kitpvp.earth_minecart,tag=kitpvp.earth_minion_new] kitpvp.minecart_life 900
