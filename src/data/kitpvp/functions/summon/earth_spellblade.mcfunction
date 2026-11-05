# 地球·33 术战士：头戴哭泣的黑曜石、穿一身紫色皮革（胸甲/裤子/靴子，末影人同色 8991416，全部耐久 I）、
# 主手火焰附加 I 木剑、副手耐久 I 雪球（纯装饰，打人还是用主手剑）
# 不给急迫：Java 版急迫只影响挖掘，不影响挥刀，僵尸身上等于白给一个特效（用户 m01900 要求去掉）
# 砍中谁就在谁脚下铺细雪（10 秒后收回）——铺雪在 tick.mcfunction:271 判（挨打那一帧 + 3 格内有术战士）→ skill/earth/spellblade_hit，不在这里铺
# 火焰附加对生物也生效：Mob.doHurtTarget 会读主手武器上的 fire_aspect，lvl 1 = 点燃 4 秒
# ★ 目标着火时那格细雪会被踩化、火同时被扑掉（原版 Powder Snow 规则），这是用户认可的表现
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_spellblade","kitpvp.earth_minion","kitpvp.earth_minion_new"],CustomName:'{"text":"术战士","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:wooden_sword",Count:1b,tag:{Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]}},{id:"minecraft:snowball",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:8991416},Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:8991416},Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:8991416},Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}},{id:"minecraft:crying_obsidian",Count:1b}]}
