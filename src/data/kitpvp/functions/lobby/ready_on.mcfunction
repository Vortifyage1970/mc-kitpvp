# 进入准备：清旧钓竿后由 give_items 按 ready 标签重发"已准备"版（同 tick 完成，看不见闪烁）
tag @s add kitpvp.ready

clear @s minecraft:carrot_on_a_stick{KitLobbyRod:1b}
function kitpvp:lobby/give_items

title @s actionbar {"text":"已准备","color":"gold"}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.6

function kitpvp:lobby/ready_check
