# ===== 纵火狂：燃烧瓶自动补货 =====
# 调用方：skill/dispatch.mcfunction
# 进入条件：kit=5、alive=1、cd<=0
# 逻辑：弹药 < 2 → 补 1 瓶并进 45 秒冷却；已满 → 什么都不做（cd 保持 0）
#       cd 只由两处写入，值都是 900：
#         1) skill/arsonist_cast   （投掷瞬间）
#         2) skill/arsonist_give   （补货瞬间）
#       所以满弹期间 cd 停在 0 不会导致"用掉即刻补"。

execute if score @s kitpvp.arsonist_ammo matches ..1 run function kitpvp:skill/arsonist_give
