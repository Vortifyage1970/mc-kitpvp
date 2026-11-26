# 辞令属性（幂等：同 UUID 再 add 是替换，所以每刻重挂也安全；防死亡/重生丢修饰符）
# 攻速 x10 = 基础 x(1+9)
attribute @s minecraft:generic.attack_damage modifier add 00000000-0000-0000-0000-000000000097 "kitpvp.zzw_atk" -4 add
attribute @s minecraft:generic.attack_speed modifier add 00000000-0000-0000-0000-000000000098 "kitpvp.zzw_spd" 9 multiply_base
attribute @s minecraft:generic.armor modifier add 00000000-0000-0000-0000-000000000099 "kitpvp.zzw_armor" 10 add
attribute @s minecraft:generic.armor_toughness modifier add 00000000-0000-0000-0000-000000000100 "kitpvp.zzw_tough" 10 add
