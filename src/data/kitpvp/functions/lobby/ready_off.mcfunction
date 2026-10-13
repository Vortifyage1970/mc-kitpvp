# 取消准备：清"已准备"钓竿后由 give_items 重发普通版
tag @s remove kitpvp.ready

clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}
function kitpvp:lobby/give_items

title @s actionbar {"text":"已取消准备","color":"gray"}
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.8
