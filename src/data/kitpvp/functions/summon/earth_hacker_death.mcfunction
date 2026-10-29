# 黑客被干掉：低调地宣告一下（tick 判定，见 04 §五 的"实体消失即死亡"口径）
# 音效用 1.16+ 的重生锚点衰减音：电子、短促，与"黑客"最贴
execute as @a at @s run playsound minecraft:block.respawn_anchor.deplete master @s ~ ~ ~ 0.8 0.7
tellraw @a [{"text":"低调的黑客有多可怕","color":"dark_gray","bold":true}]
