# 大厅坐标注册表——改大厅坐标时只认这一处。
#   出生点 / 返回点   0 64 0                                  ← enter / spawn / tp_to_main
#   选职业区目的地    0 63 98                                 ← tp_to_kit
#   讲台 1 目的地     -226 70 94                               ← lectern_teleport_1（音效点 -226 70.5 94）
#   讲台 2 目的地     227 67 97                                ← lectern_teleport_2（音效点 227 67.5 97）
#   传送触发区       (0,66,30)1x1x1 / (-224,70,93)1x1x3 / (0,65,81)1x1x1 / (223,67,96)1x1x3   ← lobby/teleport
#   职业压力板·表A 排 x=-226..-258（步进 -4），y=71，z=98      ← lobby/pad_enter（生成器产出）
#   职业压力板·表B 排 x=-226..-246（步进 -4），y=71，z=90
#   职业压力板·里翼    x=227..259（步进 -4），y=68，z=93 / z=101（两排）
#   ★ 压力板 / 盔甲架 / pad_enter 坐标全部由 tools/gen_lobby.py 生成，改坐标只改生成器的 ROWS 再重跑
#   讲台触发区       x=-21..-19 / 19..21，y=63..66，z=97..99   ← advancements/player/lectern_teleport_*
#   起跳按钮         (0,63,98)（任意按钮；判定盒开成整列 x -1..1 / y 62..66 / z 97..99，
#                     因为玩家站在按钮上、脚在 y=64，只写 y=63 不会触发）← advancements/player/lobby_launch
#   起跳柱           (0,64,98) 落点 → 漂浮 47 三秒；(0,70,98) 补抗性 V 三秒   ← lobby/launch + tick
spawnpoint @s 0 64 0
tp @s 0 64 0
