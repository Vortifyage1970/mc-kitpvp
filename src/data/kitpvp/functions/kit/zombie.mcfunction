# 僵尸（kit = 14）：僵尸头 + 墨绿皮革胸甲 + 铁护腿 + 铁靴子 + 石剑；靠"多一条血条"吃饭
# 最大生命 40 在被动里设；调高上限不会补血，所以选职与每次重生都给 5 秒生命恢复 V（见 04 §六）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 14
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 僵尸头原版没有护甲值：这里刻意不补，头部 0 护甲（总护甲 8 → 7，2026-11-10）
item replace entity @s armor.head with minecraft:zombie_head{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:3033902}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:3033902}}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

item replace entity @s hotbar.0 with minecraft:stone_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

function kitpvp:skill/zombie/passive

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"僵尸","color":"dark_green","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
