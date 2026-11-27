# 里·附魔师卡牌自测：把 18 张卡各打一次，看动作栏/聊天栏的播报与实际效果
# 不用开领域，也不用真的打到人——直接调卡牌函数
# 注意：会真的给出 1 颗赌徒之蛋 + 3 个魂石，测试完自己清一下背包
tellraw @s [{"text":"[自测] 18 张卡各触发一次，注意动作栏与你身上的变化","color":"yellow"}]

tellraw @s [{"text":"—— 普通 6 张 ——","color":"white"}]
function kitpvp:skill/li_ench/card/c00_mo
function kitpvp:skill/li_ench/card/c01_cui
function kitpvp:skill/li_ench/card/c02_str
function kitpvp:skill/li_ench/card/c03_spd
function kitpvp:skill/li_ench/card/c04_res
function kitpvp:skill/li_ench/card/c05_haste

tellraw @s [{"text":"—— 稀有 6 张 ——","color":"aqua"}]
function kitpvp:skill/li_ench/card/c10_fine_sw
function kitpvp:skill/li_ench/card/c11_fine_ap
function kitpvp:skill/li_ench/card/c12_sharp3
function kitpvp:skill/li_ench/card/c13_prot2
function kitpvp:skill/li_ench/card/c14_heal4
function kitpvp:skill/li_ench/card/c15_cd5s

tellraw @s [{"text":"—— 传说 6 张 ——","color":"gold"}]
function kitpvp:skill/li_ench/card/c20_level
function kitpvp:skill/li_ench/card/c21_egg
function kitpvp:skill/li_ench/card/c22_sharp5
function kitpvp:skill/li_ench/card/c23_heal10
function kitpvp:skill/li_ench/card/c24_prot5
function kitpvp:skill/li_ench/card/c25_souls

tellraw @s [{"text":"[自测] 剑进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw_fill"}},{"text":" 甲进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap_fill"}},{"text":" 剑级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 甲级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
tellraw @s [{"text":"[自测] 剑点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw"}},{"text":" 甲点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap"}},{"text":" 冷却=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"}},{"text":"   （利刃/锋利是攻击力修饰符，12/20 秒后自动摘）","color":"dark_gray"}]
