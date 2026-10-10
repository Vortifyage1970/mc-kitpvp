# ===== 幽灵魂石：召唤一只阴兵（单只）=====
# 调用方：summon/ghost_minion_pair
# 执行位置 / 朝向 = 召唤点（由调用方 positioned 设定）
#
# 规格：
#   - 空手骷髅（HandItems 给空 + CanPickUpLoot:0b → 保证近战 AI，不会捡弓变远程）
#   - Health 5.0f = 5 点血
#   - 抗性提升 V（Id 11b / Amplifier 4）+ 隐身 I（Id 14b / Amplifier 0），400 刻 = 20 秒
#   - PersistenceRequired + Silent
#   - 头部槽戴 barrier：非耐久物品，不消耗、不显示，兼作"防白天自燃"
#
# 防自燃原理（1.20.1 原版）：
#   AbstractSkeleton 在判断是否被日晒点燃前，先看 HEAD 槽是否为空。
#   非空则取消点燃，且仅对"可损坏物品"扣耐久。
#   barrier 不是可损坏物品 → 永不消耗 → 永久有效。
#
# 备选头部（若 barrier 在你的资源包/视角下可见）：
#   - minecraft:structure_void   更不可能显示
#   - minecraft:wither_skeleton_skull  黑色立体方块，最低调的"可见"选项

summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.ghost_minion","kitpvp.ghost_minion_new"],CustomName:'{"text":"阴兵"}',CustomNameVisible:0b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:5.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:chain",Count:1b}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:400,ShowParticles:0b},{Id:14b,Amplifier:0b,Duration:400,ShowParticles:0b}]}
