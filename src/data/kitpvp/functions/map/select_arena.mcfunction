# ===== 选择地图：竞技场（id=2） =====
# 由 map/select_menu 的 [ 竞技场 ] 按钮触发，@s = 点击者

scoreboard players set #global kitpvp.map 2

tellraw @s [{"text":"[地图] ","color":"aqua","bold":true},{"text":"已选择：","color":"gray"},{"text":"竞技场","color":"red","bold":true}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
