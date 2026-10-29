# 僵尸的被动：多一条血条（最大生命 40 = 原版 20 + 20）
# 调高上限只变长血条、不回血，所以每次重挂都跟一发 5 秒生命恢复 V 把第二条血补满
# 选职由 kit/zombie 调用，重生由 player/after_death 重挂（重生会清掉药水效果，见 04 §六）
attribute @s minecraft:generic.max_health base set 40
effect give @s minecraft:regeneration 5 4 true
