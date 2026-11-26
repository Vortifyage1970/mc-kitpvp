# ===== 药剂师（kit 12）=====
# 技能组 1：四瓶喷溅药剂，投出任意一瓶就收走整套并进 30 秒冷却，冷却走完补满一套。
# 技能组 2：四瓶饮用式秘药，每条命只能用其中一瓶，用过即锁到死亡（player/after_death 解锁补满）。
# 喷溅药水在本服有多个来源（纵火狂燃烧瓶、本职业），used:splash_potion 只能当粗筛：
# 用"上一刻手持哪一种"的 tag + 分数快照分流，last 的推进无条件（见 05 §12）。
tag @a remove kitpvp.hold_pa_prev
tag @a[tag=kitpvp.hold_pa] add kitpvp.hold_pa_prev
tag @a[scores={kitpvp.kit=12}] remove kitpvp.hold_pa
# 主手或副手拿着都算（剑在主手时右键用的是副手药水）
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistPotion run tag @s add kitpvp.hold_pa
execute as @a[scores={kitpvp.kit=12}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistPotion:1b}}] run tag @s add kitpvp.hold_pa
execute as @a[scores={kitpvp.kit=12}] run scoreboard players operation @s kitpvp.pa_type_prev = @s kitpvp.pa_type
scoreboard players set @a[scores={kitpvp.kit=12}] kitpvp.pa_type 0
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistSpeed run scoreboard players set @s kitpvp.pa_type 1
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistRegen run scoreboard players set @s kitpvp.pa_type 2
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistJump run scoreboard players set @s kitpvp.pa_type 3
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistInvis run scoreboard players set @s kitpvp.pa_type 4
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistSpeed:1b}}] run scoreboard players set @s kitpvp.pa_type 1
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistRegen:1b}}] run scoreboard players set @s kitpvp.pa_type 2
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistJump:1b}}] run scoreboard players set @s kitpvp.pa_type 3
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistInvis:1b}}] run scoreboard players set @s kitpvp.pa_type 4
execute as @a[scores={kitpvp.kit=12,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.alchemist_used > @s kitpvp.alchemist_last run function kitpvp:skill/alchemist/cast

tag @a remove kitpvp.hold_pa_drink_prev
tag @a[tag=kitpvp.hold_pa_drink] add kitpvp.hold_pa_drink_prev
tag @a[scores={kitpvp.kit=12}] remove kitpvp.hold_pa_drink
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistElixir run tag @s add kitpvp.hold_pa_drink
execute as @a[scores={kitpvp.kit=12}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistElixir:1b}}] run tag @s add kitpvp.hold_pa_drink
execute as @a[scores={kitpvp.kit=12}] run scoreboard players operation @s kitpvp.pa_drink_type_prev = @s kitpvp.pa_drink_type
scoreboard players set @a[scores={kitpvp.kit=12}] kitpvp.pa_drink_type 0
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistFireRes run scoreboard players set @s kitpvp.pa_drink_type 1
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistStrength run scoreboard players set @s kitpvp.pa_drink_type 2
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistSlowFall run scoreboard players set @s kitpvp.pa_drink_type 3
execute as @a[scores={kitpvp.kit=12}] if data entity @s SelectedItem.tag.KitAlchemistTurtle run scoreboard players set @s kitpvp.pa_drink_type 4
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_drink_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistFireRes:1b}}] run scoreboard players set @s kitpvp.pa_drink_type 1
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_drink_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistStrength:1b}}] run scoreboard players set @s kitpvp.pa_drink_type 2
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_drink_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistSlowFall:1b}}] run scoreboard players set @s kitpvp.pa_drink_type 3
execute as @a[scores={kitpvp.kit=12,kitpvp.pa_drink_type=0}] if data entity @s Inventory[{Slot:40b,tag:{KitAlchemistTurtle:1b}}] run scoreboard players set @s kitpvp.pa_drink_type 4
execute as @a[scores={kitpvp.kit=12,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.alchemist_drink_used > @s kitpvp.alchemist_drink_last run function kitpvp:skill/alchemist/elixir_cast

# 掉进虚空的喷溅药水（只认本职业的共用标记）
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitAlchemistPotion:1b}}},y=-100,dy=100]
# 冷却走完补满一套；#state 守卫同太阳，避免在大厅里反复发药

# ===== 里·驯兽师（kit 30）=====
# 技能组 1（cd 15 秒）与技能组 2（cd2 60 秒）各自是"整组共享冷却"：用掉任意一枚，整组收走，冷却走完补满。
# 骷髅 / 恼鬼 / 烈焰人蛋与魂石共用同一统计，所以每枚蛋各配一对 used/last（last 无条件推进），
# 再由 spawn_* 用蛋的 EntityTag 确认"这次真的是本职业的蛋"（见 04 §五）。
# 冷却走完补满整套（自愈式，同太阳 / 药剂师）；#state 守卫避免在大厅里反复发蛋
