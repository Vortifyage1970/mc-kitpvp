# 由 tick 检测到"手持手炮从已装填翻到未装填"后调用：射击即进入冷却
scoreboard players set @s kitpvp.cd 600
# 与换弹同款：冷却归零时由 tick 播报"手炮换弹已就绪"
tag @s add kitpvp.pirate_reload_cd

title @s actionbar {"text":"手炮已射击，换弹冷却 30 秒","color":"dark_blue"}
