# 地球·48 预言家：每 15 秒说一句真话（场上人数 / 血快见底的 / 离它最近的人）
# 头是望远镜；NoAI 让他站着不动 —— 它一开口就暴露位置，玩家会追着杀它
# 说话时才现读一次玩家血量（×100 存整数），不占每刻的常驻开销
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_oracle"],CustomName:'{"text":"预言家","color":"light_purple"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:spyglass",Count:1b}],NoAI:1b}
scoreboard players set @e[tag=kitpvp.earth_oracle] kitpvp.earth_cd_a 300
