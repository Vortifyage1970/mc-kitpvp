# 永久被动；死亡会清空药水效果，重生由 player/after_death 重挂
effect give @s minecraft:slowness infinite 0 true
effect give @s minecraft:mining_fatigue infinite 0 true

# 最大生命 20 → 10（砍半）。原版重生会重建玩家属性，base set 会丢，
# 所以和僵尸的 40 血一样挂在这个"选职业 + 重生都会跑"的被动里（见 04 §六）。
attribute @s minecraft:generic.max_health base set 10
