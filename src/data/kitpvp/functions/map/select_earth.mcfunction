# ===== 选择地图：地球（id=7） =====
# 由 map/select_menu 的 [ 地球 ] 按钮触发，@s = 点击者

scoreboard players set #global kitpvp.map 7

tellraw @s [{"text":"[地图] ","color":"aqua","bold":true},{"text":"已选择：","color":"gray"},{"text":"地球","color":"green","bold":true}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5