# ===== 显示自己的调试状态 =====
# 调用：/function kitpvp:debug/status

tellraw @s [{"text":"═══════ 我的状态 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"职业ID: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kit"},"color":"yellow"},{"text":"   命数: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"red"},{"text":"   存活: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.alive"},"color":"green"}]
tellraw @s [{"text":"冷却: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.cd"},"color":"aqua"},{"text":"   第二冷却: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.cd2"},"color":"aqua"}]
tellraw @s [{"text":"击杀: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kills"},"color":"light_purple"},{"text":"   死亡: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.deaths"},"color":"dark_red"}]
tellraw @s [{"text":"无敌剩余: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.inv"},"color":"gold"},{"text":"   死亡检测: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.death_detect"},"color":"red"}]
tellraw @s [{"text":"金苹果 used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.gapple_used"},"color":"gold"},{"text":" / ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.gapple_last"},"color":"gold"}]
tellraw @s [{"text":"全局 state: ","color":"gray"},{"score":{"name":"#state","objective":"kitpvp.game"},"color":"aqua"},{"text":"   幸存者: ","color":"gray"},{"score":{"name":"#survivors","objective":"kitpvp.game"},"color":"green"},{"text":"   地图ID: ","color":"gray"},{"score":{"name":"#global","objective":"kitpvp.map"},"color":"yellow"},{"text":"   倒计时: ","color":"gray"},{"score":{"name":"#global","objective":"kitpvp.timer"},"color":"gold"},{"text":"   test: ","color":"gray"},{"score":{"name":"#test","objective":"kitpvp.game"},"color":"red"}]
tellraw @s [{"text":"标签: ","color":"gray"},{"nbt":"Tags","entity":"@s","color":"yellow"}]
tellraw @s [{"text":"═════════════════════","color":"gold","bold":true}]
