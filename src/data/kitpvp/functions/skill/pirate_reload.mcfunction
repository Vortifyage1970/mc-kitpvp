# ===== 海盗：换弹 =====
# 调用方：skill/pirate_pickup（已确认 @s 是海盗）
# @s = 海盗
#
# 冷却用 kitpvp.cd（主技能冷却，tick 已在递减，无需新增递减行）。
# 副作用：cd > 0 期间 skill/dispatch 不会对该玩家调用——
#   海盗没有自动技能，无害；若以后加自动技能，请改用 cd2。
#
# cd <= 0 → 「重置」烟花火箭为 1 发 + 进 30 秒冷却
# cd > 0  → 仅提示
#
# ⚠ set cd 必须放在最后一行：写在前面会把后面的 ..0 判定全部拦死。

execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"换弹冷却中","color":"gray"}

execute if score @s kitpvp.cd matches ..0 run clear @s minecraft:firework_rocket{KitPirateRocket:1b}
execute if score @s kitpvp.cd matches ..0 run give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1
execute if score @s kitpvp.cd matches ..0 run title @s actionbar {"text":"换弹完成：手炮炮弹 ×1","color":"dark_blue"}
execute if score @s kitpvp.cd matches ..0 run playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.0
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 600
