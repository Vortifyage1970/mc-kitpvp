# 地球·48 预言家：每 15 秒说一句真话（场上人数 / 血快见底的 / 离它最近的人）
# 头是潜影盒，主手锋利 V 望远镜、副手附魔书；会走会打人（原来是 NoAI 站桩）—— 它一开口就暴露位置，玩家会追着杀它
# 说话时才现读一次玩家血量（×100 存整数），不占每刻的常驻开销
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_oracle"],CustomName:'{"text":"预言家","color":"light_purple"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:spyglass",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}},{id:"minecraft:enchanted_book",Count:1b,tag:{StoredEnchantments:[{id:"minecraft:sharpness",lvl:5}]}}],ArmorItems:[{},{},{},{id:"minecraft:shulker_box",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_oracle] kitpvp.earth_cd_a 300
