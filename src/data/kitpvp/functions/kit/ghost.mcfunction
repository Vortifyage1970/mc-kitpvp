# 幽灵（kit = 6）：仅 1 条命；受伤发光由 advancement kitpvp:player/ghost_hurt 触发
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 6
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 1

# 金斧不带附魔，实际伤害 8 / 攻速 1.1 全靠修饰符（基础值 1 / 4，故写 7.0 / -2.9，见 04 §九）
give @s minecraft:golden_axe{Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.ghost_axe_damage",Amount:7.0,Operation:0,UUID:[I;6,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.ghost_axe_speed",Amount:-3.0,Operation:0,UUID:[I;6,0,0,2],Slot:"mainhand"}]} 1
give @s minecraft:player_head{SkullOwner:{Id:[I;-1220463536,1462192721,-1857779687,666763920],Properties:{textures:[{Value:"ewogICJ0aW1lc3RhbXAiIDogMTc5NTY4NzgyNjMxMywKICAicHJvZmlsZUlkIiA6ICJiNzQxMzQ1MDU3Mjc0YTUxOTE0NDg4MTkyN2JlMDI5MCIsCiAgInByb2ZpbGVOYW1lIiA6ICJHaG9zdCIsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yNTY1OGQzOWEwNWY1NDA3YTJlN2MwYWI4OGZjNTAwMzFkYTczYWIzZjY1MTg1MGQyMWU0OTFhZjY2NTlhZDYwIgogICAgfQogIH0KfQ=="}]}},Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
give @s minecraft:golden_chestplate{Unbreakable:1b,Trim:{material:"minecraft:quartz",pattern:"minecraft:vex"}} 1
give @s minecraft:cooked_beef 24

function kitpvp:skill/ghost/passive

tag @s add kitpvp.selected
tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"幽灵","color":"dark_aqua","bold":true}]
