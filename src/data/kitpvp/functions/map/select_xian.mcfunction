# ===== 选择地图：西安（id=8） =====
# 由 map/select_menu 的 [ 西安 ] 按钮触发，@s = 点击者

scoreboard players set #global kitpvp.map 8

tellraw @s [{"text":"[地图] ","color":"aqua","bold":true},{"text":"已选择：","color":"gray"},{"text":"西安","color":"gold","bold":true}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
