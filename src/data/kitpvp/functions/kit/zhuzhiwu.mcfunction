# 烛之武（kit = 97，历史）：白/珊瑚红皮革套（合计护甲 12）+ 石剑 + 熟牛排 x24
# 被动：命中任意实体有约 5% 概率把它随机传送到另一名玩家处（advancement 驱动，见 skill/zhuzhiwu/hit）
# 技能「辞令」：令牌上限 1、20 秒补货；用后 10 秒 攻击力 -4 / 攻速 x10 / 护甲 +10 / 韧性 +10
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 97
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:16777215},AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.zzw_helm",Amount:2,Operation:0,UUID:[I;97,0,0,1],Slot:"head"}]}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:15956345},AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.zzw_chest",Amount:5,Operation:0,UUID:[I;97,0,0,2],Slot:"chest"}]}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:16777215},AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.zzw_legs",Amount:3,Operation:0,UUID:[I;97,0,0,3],Slot:"legs"}]}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:16777215},AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.zzw_boots",Amount:2,Operation:0,UUID:[I;97,0,0,4],Slot:"feet"}]}

item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b} 1
give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cizhi_timer 0
scoreboard players operation @s kitpvp.cizhi_last = @s kitpvp.cizhi_used
tag @s remove kitpvp.cz_buff
function kitpvp:skill/zhuzhiwu/cizhi_remove
clear @s minecraft:sniffer_spawn_egg{KitCizhi:1b}
function kitpvp:skill/zhuzhiwu/give_token

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"烛之武","color":"gold","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
