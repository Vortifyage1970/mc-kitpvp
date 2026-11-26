# 慢拍 · 每 4 刻：多伦多矿车按钮的判定（按钮按下持续 10 刻，4 刻采样足够）。
# ⚠ 只搬了判定，`#cart_cdN` 的递减仍留在 tick/world 里按每刻走，否则冷却会变 4 倍长。
execute if score #cart_cd1 kitpvp.game matches ..0 if block 5963 65 6054 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_1
execute if score #cart_cd2 kitpvp.game matches ..0 if block 5972 65 6004 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_2
execute if score #cart_cd3 kitpvp.game matches ..0 if block 5976 65 5966 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_3
execute if score #cart_cd4 kitpvp.game matches ..0 if block 5987 65 6046 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_4
execute if score #cart_cd5 kitpvp.game matches ..0 if block 6006 65 5977 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_5
execute if score #cart_cd6 kitpvp.game matches ..0 if block 6012 74 5988 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_6
execute if score #cart_cd7 kitpvp.game matches ..0 if block 6023 65 6046 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_7
execute if score #cart_cd8 kitpvp.game matches ..0 if block 6037 65 6005 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_8
execute if score #cart_cd9 kitpvp.game matches ..0 if block 6049 65 5962 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_9
execute if score #cart_cd10 kitpvp.game matches ..0 if block 6049 65 6014 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_10
execute if score #cart_cd11 kitpvp.game matches ..0 if block 6050 65 6054 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_11

# 陷阱师：捡到别人陷阱的兜底扫描（对所有参战玩家，每 4 刻一次）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/zhanshishi/scan_fallback
