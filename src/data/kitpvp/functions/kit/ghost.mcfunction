# 幽灵（kit = 6）：仅 1 条命；受伤发光由 advancement kitpvp:player/ghost_hurt 触发
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 6
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 1

# 金斧不带附魔，实际伤害 8 / 攻速 1.1 全靠修饰符（基础值 1 / 4，故写 7.0 / -2.9，见 04 §九）
give @s minecraft:golden_axe{Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.ghost_axe_damage",Amount:7.0,Operation:0,UUID:[I;6,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.ghost_axe_speed",Amount:-2.9,Operation:0,UUID:[I;6,0,0,2],Slot:"mainhand"}]} 1
give @s minecraft:player_head{SkullOwner:"Ghost",Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
give @s minecraft:golden_chestplate{Unbreakable:1b} 1
give @s minecraft:cooked_beef 24

function kitpvp:skill/ghost/passive

tag @s add kitpvp.selected
