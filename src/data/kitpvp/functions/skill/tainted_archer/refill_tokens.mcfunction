# 里·弓箭手令牌补货：放在慢拍、且排在 turret_cast / dispatch（使用侧）之后，避免"用掉就秒补"。
# 各自 cd 走完才发；使用侧 *_cast 负责在用掉时起计（同纵火狂 / 末影人）。
execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/tainted_archer/refill_turret
execute if score @s kitpvp.cd2 matches ..0 run function kitpvp:skill/tainted_archer/refill_core
