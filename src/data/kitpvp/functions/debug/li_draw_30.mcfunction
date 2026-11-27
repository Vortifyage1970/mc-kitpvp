# 里·附魔师自测：一次连抽 30 张，用来看抽卡分布（不需要真的打到人）
# 5 张的样本太小，看六张卡的稀有度/进度分布至少要 30 张
tellraw @s [{"text":"[自测] 连抽 30 张卡，看聊天栏/动作栏的卡名分布","color":"yellow"}]
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
tellraw @s [{"text":"[自测] 剑进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw_fill"}},{"text":" 甲进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap_fill"}},{"text":" 剑级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 甲级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
tellraw @s [{"text":"[自测] 剑点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw"}},{"text":" 甲点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap"}},{"text":"   （3 点 = 1 级，剑要拿在主手才升级）","color":"dark_gray"}]
