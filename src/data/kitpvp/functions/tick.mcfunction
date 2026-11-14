# 每刻入口：按顺序调用 tick/* 各模块。模块内容就是拆分前 tick.mcfunction 的连续片段，
# 顺序与拆分前逐行一致 —— 04 §一 / §六 里那些"顺序有意义"的约定仍然成立，改顺序前先读那两节。
function kitpvp:tick/life
function kitpvp:tick/lobby
function kitpvp:tick/kits_a
function kitpvp:tick/kits_b
function kitpvp:tick/kits_c
function kitpvp:tick/kits_d
function kitpvp:tick/kits_e
function kitpvp:tick/kits_f
function kitpvp:tick/player
function kitpvp:tick/world

# 慢拍闸门：slow2 = 每 2 刻、slow4 = 每 4 刻。搬进去的是幂等判定（读 used 快照 / cd 到点补发），
# 不要往里放每刻重建的 tag、每调用一次 -1 的计时器、投掷类 cast、箭清理与实体跟随。
scoreboard players add #tick_slow2 kitpvp.game 1
execute if score #tick_slow2 kitpvp.game matches 2.. run scoreboard players set #tick_slow2 kitpvp.game 0
execute if score #tick_slow2 kitpvp.game matches 0 run function kitpvp:tick/slow2
scoreboard players add #tick_slow4 kitpvp.game 1
execute if score #tick_slow4 kitpvp.game matches 4.. run scoreboard players set #tick_slow4 kitpvp.game 0
execute if score #tick_slow4 kitpvp.game matches 0 run function kitpvp:tick/slow4
