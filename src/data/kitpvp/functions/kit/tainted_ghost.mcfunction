# 里·幽灵（kit = 28）：仅 1 条命；护甲直接穿戴、带绑定诅咒，失明 / 隐身 / 速度 I 为常驻被动
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 28
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 1

# 护甲槽直接写满，玩家不需要也不能手动穿脱（绑定诅咒）；护甲 8 / 韧性 2 全由钻石胸甲提供
item replace entity @s armor.head with minecraft:player_head{SkullOwner:"TaintedGhost",Enchantments:[{id:"minecraft:protection",lvl:10},{id:"minecraft:binding_curse",lvl:1}]}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:5},{id:"minecraft:binding_curse",lvl:1}]}

# 金斧基础 7 伤害 / 攻速 1.0，锋利 VIII 再加 4.5（0.5 × 等级 + 0.5）
item replace entity @s hotbar.0 with minecraft:golden_axe{Unbreakable:1b,Enchantments:[{id:"minecraft:sharpness",lvl:8}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 10

function kitpvp:skill/tainted_ghost/passive

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·幽灵","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
