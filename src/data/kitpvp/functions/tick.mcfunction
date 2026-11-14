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
