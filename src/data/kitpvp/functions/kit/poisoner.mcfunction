# 斩杀线（kit = 98）：深紫皮革 + 石剑「淬毒短匕」；命中淬毒、残血（≤3 心）斩杀、毒雾对召唤物 DoT
# 被动走 advancement（与狼人共用 werewolf_hit），主动走 lingering_potion 的 used 计数（见 05 §12）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 98
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.poisoner_hit_cd 0

# 深紫皮革 4915330 = 0x4B0082；总护甲 8（皮革头 1 + 胸 3 + 腿 2 + 铁靴 2）
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:4915330}}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:4915330}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:4915330}}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

# 淬毒短匕：石剑面板 5 / 攻速 1.6；打上 KitPoisonerBlade 供命中被动认武器
item replace entity @s hotbar.0 with minecraft:stone_sword{KitPoisonerBlade:1b,Unbreakable:1b,display:{Name:'{"text":"淬毒短匕","color":"dark_purple"}'}}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

# 开局 2 瓶毒雾（上限 2，补货见 skill/poisoner/auto）
function kitpvp:skill/poisoner/give
function kitpvp:skill/poisoner/give

function kitpvp:skill/poisoner/passive

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"斩杀线","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
