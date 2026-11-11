# 补货：各自 cd 走完才发；满仓时什么都不发、cd 停在 0（同纵火狂 / 里·弓箭手）
execute if score @s kitpvp.bomb_big_cd matches ..0 run function kitpvp:skill/tainted_bomber/refill_big
execute if score @s kitpvp.bomb_track_cd matches ..0 run function kitpvp:skill/tainted_bomber/refill_track
execute if score @s kitpvp.bomb_nuke_cd matches ..0 run function kitpvp:skill/tainted_bomber/refill_nuke
