# 金星（kit = 67）：铁铲 + 铁/金混搭护甲；开局一条自动驯服的舔狗，三个模块各走独立冷却
# 冷却分配：制冷 cd（30 秒）/ 武装 cd2（60 秒）/ 自爆 venus_cd3（30 秒，兼作舔狗复活计时）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 67
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

# 原版铁铲：沿用默认修饰符（伤害 2.5 / 攻速 1.0），不写 AttributeModifiers
item replace entity @s weapon.mainhand with minecraft:iron_shovel{Unbreakable:1b}
give @s minecraft:cooked_porkchop 16

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.venus_cd3 0
scoreboard players set @s kitpvp.venus_dog_timer 0
scoreboard players set @s kitpvp.coldness 0
tag @s remove kitpvp.venus_dog_dead

# 舔狗归属编号（1..6）：舔狗身上记同一个号，用来"认出自己的狗"和排除主人
scoreboard players add @s kitpvp.vtid 0
execute if score @s kitpvp.vtid matches 0 run scoreboard players add #vtid kitpvp.game 1
execute if score @s kitpvp.vtid matches 0 if score #vtid kitpvp.game matches 7.. run scoreboard players set #vtid kitpvp.game 1
execute if score @s kitpvp.vtid matches 0 run scoreboard players operation @s kitpvp.vtid = #vtid kitpvp.game

function kitpvp:skill/venus/summon_dog
function kitpvp:skill/venus/give_chill
function kitpvp:skill/venus/give_arm
function kitpvp:skill/venus/give_bomb

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"金星","color":"gold","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
