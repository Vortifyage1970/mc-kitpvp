# 地球·33 术战士：头戴哭泣的黑曜石、手拿火焰附加 I 的木剑；砍中谁就在谁脚下铺细雪（10 秒后收回）
# 火焰附加对生物也生效：Mob.doHurtTarget 会读主手武器上的 fire_aspect，lvl 1 = 点燃 4 秒
# 细雪那块走 advancements/player/spellblade_hit.json → skill/earth/spellblade_hit，不在这里铺
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_spellblade"],CustomName:'{"text":"术战士","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:wooden_sword",Count:1b,tag:{Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]}},{}],ArmorItems:[{},{},{},{id:"minecraft:crying_obsidian",Count:1b}]}
