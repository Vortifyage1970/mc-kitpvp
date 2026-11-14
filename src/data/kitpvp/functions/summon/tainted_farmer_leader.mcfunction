# 起义领袖：250 血僵尸、钻石锄、玩家头颅 + 钻胸甲；效果常驻（力量 II / 速度 I）
# Health 必须与 Attributes.max_health 一起写，否则会被原版 20 血夹回去（见 04 §十七）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.tf_leader","kitpvp.tf_new","kitpvp.team_new"],CustomName:'{"text":"农民起义领袖","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:diamond_hoe",Count:1b},{}],ArmorItems:[{},{},{id:"minecraft:diamond_chestplate",Count:1b},{id:"minecraft:player_head",Count:1b}],Health:250f,Attributes:[{Name:"minecraft:generic.max_health",Base:250.0}]}
effect give @e[tag=kitpvp.tf_leader,tag=kitpvp.tf_new] minecraft:strength infinite 1 true
effect give @e[tag=kitpvp.tf_leader,tag=kitpvp.tf_new] minecraft:speed infinite 0 true
