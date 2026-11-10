# 地球·36 矿车：蠹虫当坐骑、背上驮着一条橡木船；常驻速度 VI + 虚弱 X
# 上下位：蠹虫是外层（主实体），船在 Passengers 里当乘客 —— 与交警 / 船夫正好相反，别抄反
# 船挂了三个标签：earth_mount（reset 统一清载具）、earth_minecart_boat（"这只矿车自己的船"，孤儿船判定用）、
# earth_cart_boat（背上的船专用标记，谁想单独点名这份船就用它）
# 虚弱 X 让蠹虫的近战彻底归零（每级 -4 点伤害，远超它那 1 点），速度 VI 让它跑得飞快但打不死人
# ★ 效果用 effect give 发、不写进 NBT 的 ActiveEffects：写在召唤 NBT 里那套在这台机器上不显现（改了三次数值都"没感觉"），
#   改成和交警一样"召唤之后再 effect give"，生效与否一眼能看见（头顶会有图标）
# 船是"无法破坏"的：Invulnerable:1b 挡掉玩家/怪物对它的伤害；/kill 与 reset 里的按 tag 清除不受影响
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_minecart"],CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Invisible:1b,Invulnerable:1b,Passengers:[{id:"minecraft:boat",Type:"oak",Tags:["kitpvp.earth_mount","kitpvp.earth_minecart_boat","kitpvp.earth_cart_boat"],Invulnerable:1b,CustomName:'{"text":"矿车","color":"gray"}',CustomNameVisible:1b}]}
# 速度改成属性修饰符 +100%（乘算）：速度 VI 的药水效果在骑乘/坐船时看着不直观，属性加成一处生效
attribute @e[tag=kitpvp.earth_minecart,tag=kitpvp.earth_minion_new] minecraft:generic.movement_speed modifier add 00000000-0000-0000-0000-000000000036 kitpvp.minecart_speed 1.0 multiply
effect give @e[tag=kitpvp.earth_minecart] minecraft:weakness infinite 9 true
# 40 秒（800 刻）后连蠹虫带船自毁：只给刚召出的这一只埋倒计时（earth_minion_new 在 link 之后就没了）
scoreboard players set @e[tag=kitpvp.earth_minecart,tag=kitpvp.earth_minion_new] kitpvp.minecart_life 800
