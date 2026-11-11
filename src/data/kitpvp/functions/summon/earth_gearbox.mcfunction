# 地球·28 变速器：6 格内没有除召唤者以外的玩家时极速冲刺（速度 V），有人靠近就变慢（缓慢 IV，无抗性、无急迫）
# 效果在 tick 里跑（见 skill/earth/gearbox_aura）；织布机当头饰顺便防火（僵尸戴头盔就不烧）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_gearbox"],CustomName:'{"text":"变速器","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:loom",Count:1b}],Attributes:[{Name:"minecraft:generic.movement_speed",Base:0.23}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_cd_a 10
# 记下是谁召的：手召（owner 0、etid 也是 0）时也认得出主人，不会被算进"有人靠近"
scoreboard players set @a kitpvp.gb_summoner 0
scoreboard players set @s kitpvp.gb_summoner 1
# 当前模式（0 = 空旷极速 / 1 = 有人变慢），只用来判断"切换"那一刻要不要响音效
scoreboard players set @e[tag=kitpvp.earth_gearbox] kitpvp.gb_mode 0
