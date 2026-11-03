# 冥王星（kit = 76）：皮革护腿 + 石剑；本体永久隐身 + 抗性提升 V
# 机制照抄金星的舔狗：一只无 AI 的鹦鹉「冥王星」当分身——它一死，本体跟着强制死亡，重生后再补一只
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 76
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:stone_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

# 鹦鹉归属编号：每选一次领一个新号（同金星的 vtid），换号前先按旧号清掉那只
execute if score @s kitpvp.ptid matches 1.. run function kitpvp:skill/pluto/despawn
scoreboard players set @s kitpvp.ptid 0
scoreboard players add #ptid kitpvp.game 1
scoreboard players operation @s kitpvp.ptid = #ptid kitpvp.game
scoreboard players set @s kitpvp.parrot_miss 0

function kitpvp:skill/pluto/passive
function kitpvp:skill/pluto/spawn

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"冥王星","color":"dark_blue","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
