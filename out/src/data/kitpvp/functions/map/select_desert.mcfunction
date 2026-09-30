# ===== 选择地图：沙漠（id=1） =====
# 由 map/select_menu 的 [ 沙漠 ] 按钮触发，@s = 点击者

scoreboard players set #global kitpvp.map 1

tellraw @s [{"text":"[地图] ","color":"aqua","bold":true},{"text":"已选择：","color":"gray"},{"text":"沙漠","color":"yellow","bold":true}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
