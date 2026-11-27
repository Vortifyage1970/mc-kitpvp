# 里·附魔师自测：连抽 5 张（不需要真打到人）
tellraw @s [{"text":"[自测] 连抽 5 张卡，看聊天栏/进度条","color":"yellow"}]
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
tellraw @s [{"text":"[自测] 剑进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw_fill"}},{"text":" 甲进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap_fill"}},{"text":" 剑级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 甲级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
