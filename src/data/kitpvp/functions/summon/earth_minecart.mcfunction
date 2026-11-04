# 地球·36 矿车：蠹虫当坐骑、背上驮着一条橡木船；常驻速度 I + 虚弱 I
# 上下位：蠹虫是外层（主实体），船在 Passengers 里当乘客 —— 与交警 / 船夫正好相反，别抄反
# 船挂了三个标签：earth_mount（reset 统一清载具）、earth_minecart_boat（"这只矿车自己的船"，孤儿船判定用）、
# earth_cart_boat（背上的船专用标记，谁想单独点名这份船就用它）
# 虚弱 I 把蠹虫那 1 点近战直接削到 0（原版最低 0），速度 I 让它跑得快但打不死人
# 船是"无法破坏"的：Invulnerable:1b 挡掉玩家/怪物对它的伤害；/kill 与 reset 里的按 tag 清除不受影响
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_minecart"],CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ActiveEffects:[{Id:1b,Amplifier:0b,Duration:-1,ShowParticles:0b},{Id:18b,Amplifier:0b,Duration:-1,ShowParticles:0b}],Passengers:[{id:"minecraft:boat",Type:"oak",Tags:["kitpvp.earth_mount","kitpvp.earth_minecart_boat","kitpvp.earth_cart_boat"],Invulnerable:1b,CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b}]}
