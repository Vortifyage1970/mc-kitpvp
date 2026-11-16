# 地球魂石的队槽识别：直接复用 util/team_index（0..36 一整套，含炸弹兵 / 里·农夫）
function kitpvp:util/team_index

# 只有在"主人原本不在任何队"时才分配地球槽（先 link 拿 etid 再抬 18）。
# ⚠ 绝不能对 team_index 返回的 1..6（幽灵槽）也做 +18 —— 那会把幽灵主人误算成地球段，
#   导致召出的生灵 join 到 earth_N 而主人还在 ghost_N，生灵反过来打主人/主人的召唤物。
execute if score #steam kitpvp.game matches 0 run function kitpvp:skill/soul/earth_assign
