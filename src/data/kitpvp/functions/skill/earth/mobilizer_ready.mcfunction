# @s = 点了"准备"的那个玩家（由聊天框按钮的 clickEvent 调进来）
# 先判后写：只在 0 的时候说话并置 1，连点不会刷屏；结算完是 2，点了也不响应
execute if score @s kitpvp.mob_ready matches 0 run tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray","italic":true},{"text":"你真棒。","color":"green","italic":true}]
execute if score @s kitpvp.mob_ready matches 0 run scoreboard players set @s kitpvp.mob_ready 1
