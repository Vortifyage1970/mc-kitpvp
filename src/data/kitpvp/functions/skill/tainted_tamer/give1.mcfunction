# 技能组 1：三枚蛋各 1 个。整套同进同出，冷却走完由 restock1 整体补满
# 蛋上打两个 tag：KitTtGroup1 认整套，EntityTag 里的 kitpvp.tt_spawn_* 认"蛋真的刷出了本职业的生物"
give @s minecraft:zombie_spawn_egg{KitTtGroup1:1b,KitTtZombie:1b,EntityTag:{Tags:["kitpvp.tt_spawn","kitpvp.tt_spawn_zombie"],DeathLootTable:"minecraft:empty"},display:{Name:'{"text":"亡灵仆从蛋","color":"dark_red","bold":true}'}} 1
give @s minecraft:skeleton_spawn_egg{KitTtGroup1:1b,KitTtSkeleton:1b,EntityTag:{Tags:["kitpvp.tt_spawn","kitpvp.tt_spawn_skeleton"],DeathLootTable:"minecraft:empty"},display:{Name:'{"text":"骸骨仆从蛋","color":"dark_red","bold":true}'}} 1
give @s minecraft:creeper_spawn_egg{KitTtGroup1:1b,KitTtCreeper:1b,EntityTag:{Tags:["kitpvp.tt_spawn","kitpvp.tt_spawn_creeper"],DeathLootTable:"minecraft:empty"},display:{Name:'{"text":"爆破仆从蛋","color":"dark_red","bold":true}'}} 1
