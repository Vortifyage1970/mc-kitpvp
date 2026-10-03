# —— 传送 + 音效 ——
# 顺序铁律：判定行 → 音效行 → tp 行。
# 因为条件多半是基于坐标/距离的，tp 会立刻改变坐标让条件失效，
# 所以 tp 必须排在最末，"先 tp 再播"是无声的头号原因。
#
# 两行条件重复写是刻意的：不要为了省事改成先 tp 后播。
execute if <你的传送条件> run function kitpvp:lobby/teleport_sound
execute if <你的传送条件> run tp @s <x> <y> <z>
