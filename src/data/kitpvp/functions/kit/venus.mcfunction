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

# 舔狗归属编号：每选一次金星就领一个新号，旧号不复用——两人同号会让双方都认错狗（见 04 §十四）
# 换号之前先把旧号那只清掉：首次选职时 kit 还不是 67，util/clear_player 那段不会替我们清
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
execute if score @s kitpvp.vtid matches 1.. as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run kill @s

scoreboard players set @s kitpvp.vtid 0
scoreboard players add #vtid kitpvp.game 1
scoreboard players operation @s kitpvp.vtid = #vtid kitpvp.game

function kitpvp:skill/venus/summon_dog
function kitpvp:skill/venus/give_chill
function kitpvp:skill/venus/give_arm
function kitpvp:skill/venus/give_bomb

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"金星","color":"gold","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
