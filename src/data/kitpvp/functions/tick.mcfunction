execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join

execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1
execute as @a[scores={kitpvp.sun_reload=1..}] run scoreboard players remove @s kitpvp.sun_reload 1
execute as @a[scores={kitpvp.venus_cd3=1..}] run scoreboard players remove @s kitpvp.venus_cd3 1
execute as @a[tag=kitpvp.pirate_reload_cd,tag=kitpvp.selected,tag=!kitpvp.spectator,scores={kitpvp.kit=9,kitpvp.alive=1,kitpvp.cd=..0}] run title @s actionbar {"text":"手炮换弹已就绪","color":"dark_blue"}
tag @a[tag=kitpvp.pirate_reload_cd,scores={kitpvp.cd=..0}] remove kitpvp.pirate_reload_cd

# 主大厅：大厅物品兜底补发（60 刻节流，牺牲 3 秒延迟换掉每刻全背包扫描）
scoreboard players add #lobby kitpvp.game 1
execute if score #lobby kitpvp.game matches 60.. run scoreboard players set #lobby kitpvp.game 0
execute if score #lobby kitpvp.game matches 0 as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] run function kitpvp:lobby/give_items
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] run effect give @s minecraft:saturation 1 1 true
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] at @s run function kitpvp:lobby/teleport
# 起跳柱 (0,70,98)：经过时补 3 秒抗性 V（盒高 3 格 —— 漂浮 47 每刻约 2.35 格，薄盒会整格漏检）
execute as @a[tag=kitpvp.in_lobby,x=-0.5,y=70,z=97.5,dx=1,dy=3,dz=1] run effect give @s minecraft:resistance 3 4 true
function kitpvp:lobby/display_lock
function kitpvp:lobby/pad
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] if score @s kitpvp.ready_used > @s kitpvp.ready_last run function kitpvp:lobby/ready_toggle

# 坦克：令牌与魂石共用 iron_golem_spawn_egg，靠 CustomName 分流（skill/tank_dispatch）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tank_used > @s kitpvp.tank_last run function kitpvp:skill/tank/dispatch
# 到期用 ..300 而非 =300：跳刻时不漏触发
execute as @a[scores={kitpvp.cd=..300},tag=kitpvp.shield_held,tag=!kitpvp.spectator] run function kitpvp:skill/tank/expire
# distance 16 覆盖刷怪蛋右键射程；会误杀该范围内同名的装饰性生物
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾"]
# 令牌只在"真的用过"（cast 开的窗口）且冷却走完时发回，不拿"背包里没有"当依据（见 04 §四）
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.tank_handout,tag=!kitpvp.spectator] run function kitpvp:skill/tank/handout

# 箭一落地即清，防"射出→换弹→捡回"刷过上箭上限。必须每刻轮询：20 刻一次的话，落地到清理之间有窗口能捡回
# 只有场上存在用箭职业时才扫描；tag kitpvp.arrow_user 由 kit/archer 与 kit/tainted_archer 打上（见 04 §五）
execute if entity @a[tag=kitpvp.arrow_user] run kill @e[type=minecraft:arrow,nbt={inGround:1b}]

execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin/dispatch
execute as @a[scores={kitpvp.cd=..500},tag=kitpvp.assassin_hidden,tag=!kitpvp.spectator] run function kitpvp:skill/assassin/unhide
execute as @a[scores={kitpvp.kit=4}] at @s run kill @e[type=enderman,distance=..16,name="隐匿"]
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.assassin_handout,tag=!kitpvp.spectator] run function kitpvp:skill/assassin/handout

# 海盗：射击即进冷却——检测"手持的手炮从已装填翻到未装填"
# Charged 是字节，射击后键还在、值变 0b，所以必须取"值"（判路径会把 0b 也算成已装填）
tag @a remove kitpvp.pirate_charged_prev
tag @a[tag=kitpvp.pirate_charged] add kitpvp.pirate_charged_prev
tag @a remove kitpvp.pirate_charged
scoreboard players set @a[scores={kitpvp.kit=9}] kitpvp.tmp 0
execute as @a[scores={kitpvp.kit=9}] if data entity @s SelectedItem.tag.KitCrossbow store result score @s kitpvp.tmp run data get entity @s SelectedItem.tag.Charged
execute as @a[scores={kitpvp.kit=9,kitpvp.tmp=1..}] run tag @s add kitpvp.pirate_charged
execute as @a[tag=kitpvp.pirate_charged_prev,tag=!kitpvp.pirate_charged,scores={kitpvp.kit=9,kitpvp.alive=1},tag=!kitpvp.spectator] if data entity @s SelectedItem.tag.KitCrossbow run function kitpvp:skill/pirate/fire

# 里·弓箭手：两个令牌（炮台 / 熔火核心）
# ⚠ 必须带 at @s：tick 函数的执行位置是世界出生点，技能里所有 ~ 相对坐标都靠这一步锚定
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.tainted_turret_used > @s kitpvp.tainted_turret_last run function kitpvp:skill/tainted_archer/turret_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.tainted_core_used > @s kitpvp.tainted_core_last run function kitpvp:skill/tainted_archer/dispatch
# 令牌兜底补发：炮台上限 3（cd 节流 60 秒）、熔火核心上限 1（cd2 节流）；数量按背包真实值算
# ⚠ 补货必须自己置冷却，否则 count 一直 <= 上限就会每刻给一个
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.tmp 0
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] store result score @s kitpvp.tmp run clear @s minecraft:stray_spawn_egg{KitTaintedTurretEgg:1b} 0
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0,kitpvp.tmp=..2},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_archer/give_token_turret
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0,kitpvp.tmp=..2},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.cd 1200
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0,kitpvp.tmp=..2},tag=!kitpvp.spectator] run title @s actionbar {"text":"炮台令牌 +1","color":"dark_red"}
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0,kitpvp.tmp=..2},tag=!kitpvp.spectator] run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.tmp 0
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0},tag=!kitpvp.spectator] store result score @s kitpvp.tmp run clear @s minecraft:blaze_spawn_egg{KitTaintedCoreEgg:1b} 0
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0,kitpvp.tmp=..0},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_archer/give_token_core
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0,kitpvp.tmp=..0},tag=!kitpvp.spectator] run scoreboard players set @s kitpvp.cd2 2400
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0,kitpvp.tmp=..0},tag=!kitpvp.spectator] run title @s actionbar {"text":"熔火核心已就绪","color":"gold"}
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0,kitpvp.tmp=..0},tag=!kitpvp.spectator] run playsound minecraft:entity.blaze.ambient master @s ~ ~ ~ 0.6 1.2
# 炮台回血被动（石斧击打自己的炮台）的 1 秒冷却
execute as @a[scores={kitpvp.turret_heal_cd=1..}] run scoreboard players remove @s kitpvp.turret_heal_cd 1
# 炮台熔火形态：只在使用瞬间变一次（core_fire），之后各自计时 30 秒，计时归零就复原
execute as @e[tag=kitpvp.turret_molten,scores={kitpvp.turret_molten_timer=1..}] run scoreboard players remove @s kitpvp.turret_molten_timer 1
execute as @e[tag=kitpvp.turret_molten,scores={kitpvp.turret_molten_timer=..0}] run function kitpvp:skill/tainted_archer/turret_from_molten

# 里·渔夫（kit 29）：两个令牌，cd / cd2 互为对方的锁（放苍两个都锁 45 秒，放领域展开都锁 240 秒）
# ⚠ 必须带 at @s：水球球心与距离判定都靠它锚定
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tainted_fisher_blue_used > @s kitpvp.tainted_fisher_blue_last run function kitpvp:skill/tainted_fisher/blue_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tainted_fisher_domain_used > @s kitpvp.tainted_fisher_domain_last run function kitpvp:skill/tainted_fisher/domain_cast
# 计时排在 cast 之后：cast 写进去的计时器下一刻才该开始走
execute as @a[tag=kitpvp.tainted_fisher_cang] at @s run function kitpvp:skill/tainted_fisher/cang_tick
execute as @a[tag=kitpvp.tainted_fisher_domain] at @s run function kitpvp:skill/tainted_fisher/domain_tick
# 令牌发回：只认"技能刚放完、整把锁走完"的窗口（04 §四：不能改成"背包里没有就补"）
execute as @a[scores={kitpvp.kit=29,kitpvp.alive=1,kitpvp.cd=0,kitpvp.cd2=0},tag=kitpvp.tainted_fisher_handout,tag=!kitpvp.spectator] run function kitpvp:skill/tainted_fisher/handout
# 水中被动：力量 I
execute as @a[scores={kitpvp.kit=29,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_fisher/water_passive

# 纵火狂、末影人：投掷入口的调用条件里绝不能加 hold_*_prev，
# 否则投其它同种物品时 last 不推进，之后切到本职业投掷物会误触发（见 05 §12）
tag @a remove kitpvp.hold_fb_prev
tag @a[tag=kitpvp.hold_fb] add kitpvp.hold_fb_prev
tag @a remove kitpvp.hold_fb
execute as @a if data entity @s SelectedItem.tag.KitFireBomb run tag @s add kitpvp.hold_fb
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist/cast
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},tag=!kitpvp.arsonist_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/arsonist/burst
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},y=-100,dy=100]
function kitpvp:skill/arsonist/flame_tick

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
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=12,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/alchemist/refill_splash

# ===== 里·驯兽师（kit 30）=====
# 技能组 1（cd 15 秒）与技能组 2（cd2 60 秒）各自是"整组共享冷却"：用掉任意一枚，整组收走，冷却走完补满。
# 骷髅 / 恼鬼 / 烈焰人蛋与魂石共用同一统计，所以每枚蛋各配一对 used/last（last 无条件推进），
# 再由 spawn_* 用蛋的 EntityTag 确认"这次真的是本职业的蛋"（见 04 §五）。
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_zombie_used > @s kitpvp.ttamer_zombie_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_skeleton_used > @s kitpvp.ttamer_skeleton_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_creeper_used > @s kitpvp.ttamer_creeper_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_vindicator_used > @s kitpvp.ttamer_vindicator_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_witch_used > @s kitpvp.ttamer_witch_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_vex_used > @s kitpvp.ttamer_vex_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_blaze_used > @s kitpvp.ttamer_blaze_last run function kitpvp:skill/tainted_tamer/cast2
# 冷却走完补满整套（自愈式，同太阳 / 药剂师）；#state 守卫避免在大厅里反复发蛋
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=30,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_tamer/refill1
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=30,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_tamer/refill2

# ===== 金星（kit 67）=====
# 冷度：先重建"正在冷气里"的标记，再按标记分流——圈内每刻 +1、圈外每刻 -1
tag @a remove kitpvp.venus_chilled
execute as @e[tag=kitpvp.venus_chill] at @s run function kitpvp:skill/venus/chill_mark
execute as @a[tag=kitpvp.venus_chilled] run scoreboard players add @s kitpvp.coldness 1
execute as @a[tag=!kitpvp.venus_chilled,scores={kitpvp.coldness=1..}] run scoreboard players remove @s kitpvp.coldness 1
execute as @a[scores={kitpvp.coldness=101..}] run scoreboard players set @s kitpvp.coldness 100
execute as @a[scores={kitpvp.coldness=1..}] run function kitpvp:skill/venus/chill_apply

# 模块计时（挂在舔狗身上）：制冷 10 秒 / 武装 20 秒
execute as @e[tag=kitpvp.venus_chill,scores={kitpvp.venus_chill_timer=1..}] run scoreboard players remove @s kitpvp.venus_chill_timer 1
execute as @e[tag=kitpvp.venus_chill,scores={kitpvp.venus_chill_timer=..0}] run function kitpvp:skill/venus/chill_expire
execute as @e[tag=kitpvp.venus_armed,scores={kitpvp.venus_arm_timer=1..}] run scoreboard players remove @s kitpvp.venus_arm_timer 1
execute as @e[tag=kitpvp.venus_armed] run function kitpvp:skill/venus/arm_refresh
execute as @e[tag=kitpvp.venus_armed,scores={kitpvp.venus_arm_timer=..0}] run function kitpvp:skill/venus/arm_expire

# 技能入口：三枚模块令牌分别走 cd / cd2 / venus_cd3，互不影响
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_chill_used > @s kitpvp.venus_chill_last run function kitpvp:skill/venus/chill_cast
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_arm_used > @s kitpvp.venus_arm_last run function kitpvp:skill/venus/arm_cast
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_bomb_used > @s kitpvp.venus_bomb_last run function kitpvp:skill/venus/bomb_cast

# 令牌补货（自愈口径，同太阳）：只在游戏进行中发，避免在大厅反复刷
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_chill
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_arm
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.venus_cd3=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_bomb

# 舔狗跟随：每刻把落在 12 格外的狗拉回主人身边。狗只要一直在主人所在区块，
# 就不会出现"区块卸载→看不见→误判丢了→再召一只"的两只狗（见 04 §十四）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/dog_follow

# 舔狗复活：没有狗就开始 30 秒计时（自爆模块会自己置好计时，这里兜住掉虚空等意外）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.venus_dog_dead,tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/dog_alive_check
execute as @a[tag=kitpvp.venus_dog_dead,scores={kitpvp.venus_dog_timer=1..}] run scoreboard players remove @s kitpvp.venus_dog_timer 1
execute as @a[tag=kitpvp.venus_dog_dead,scores={kitpvp.alive=1,kitpvp.venus_dog_timer=..0}] at @s run function kitpvp:skill/venus/dog_respawn

# ===== 冥王星（kit 76）=====
# 鹦鹉跟随：每刻把 2 格外的鹦鹉拉到肩头
# 大厅里也要跟（选职业时就在大厅，玩家会立刻走动）
execute as @a[scores={kitpvp.kit=76,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/pluto/follow
# 鹦鹉一死 => 本体强制死亡；重生后由 player/after_death 补一只新鹦鹉
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=76,kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] at @s run function kitpvp:skill/pluto/check
# 大厅里没有 after_death 兜底（on_death 只在局内挂 respawn_pending）：鸟丢了就在大厅直接补一只
execute if score #state kitpvp.game matches 0 as @a[scores={kitpvp.kit=76},tag=!kitpvp.spectator] at @s run function kitpvp:skill/pluto/respawn

# 令牌刷出来的基础生物：蛋一用就会刷一只，兜底清（cast 里已当场清过一次）
kill @e[tag=kitpvp.venus_token]

# ===== 文明小子（kit 87）=====
# 技能组 1：喷溅口水。喷溅药水在本服有三个来源（纵火狂 / 药剂师 / 本职业），
# 靠"上一刻手持的是不是自己的口水"分流；last 无条件推进（见 05 §12）。
tag @a remove kitpvp.hold_cb_prev
tag @a[tag=kitpvp.hold_cb] add kitpvp.hold_cb_prev
tag @a[scores={kitpvp.kit=87}] remove kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s SelectedItem.tag.KitCivilSpit run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s SelectedItem.tag.KitCivilDemonSpit run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s Inventory[{Slot:40b,tag:{KitCivilSpit:1b}}] run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s Inventory[{Slot:40b,tag:{KitCivilDemonSpit:1b}}] run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.civil_used > @s kitpvp.civil_last run function kitpvp:skill/civil/cast

# 口水效果由自定义药水数据交给原版处理；此处只处理落地音效与虚空清理
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}},tag=!kitpvp.civil_spit_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/civil/spit_burst
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}},tag=!kitpvp.civil_demon_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/civil/demon_spit_burst
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}},y=-100,dy=100]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}},y=-100,dy=100]

# 技能组 2：恶魔形态（cd2 180 秒 / 持续 60 秒）
execute as @a[scores={kitpvp.kit=87,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.civil_demon_used > @s kitpvp.civil_demon_last run function kitpvp:skill/civil/demon_cast
execute as @a[tag=kitpvp.civil_demon,scores={kitpvp.civil_demon_timer=1..}] run scoreboard players remove @s kitpvp.civil_demon_timer 1
execute as @a[tag=kitpvp.civil_demon,scores={kitpvp.civil_demon_timer=..0}] at @s run function kitpvp:skill/civil/demon_end
# 恶魔形态令牌补货（cd2 走完才发）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=87,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/civil/refill_demon

# 令牌刷出来的基础生物兜底清
kill @e[tag=kitpvp.civil_token]

# ===== 李朱俊泽（kit 88）=====
# 召唤入口：猪蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一只"
execute as @a[scores={kitpvp.kit=88,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.li_pig_used > @s kitpvp.li_pig_last run function kitpvp:skill/li_zhujunze/cast
# 内联循环计时器：李朱俊泽在局内，或地球召出的 iLsacuL 存在时就一直走；两者都没有则归零
scoreboard players set #li_active kitpvp.game 0
execute if score #state kitpvp.game matches 1 if entity @a[scores={kitpvp.kit=88}] run scoreboard players set #li_active kitpvp.game 1
# 场上有任何一只 iLsacuL（地球召的、魂石召的、还有它们的 200 血复制体）循环就继续跑 ——
# 以前这里只认 earth_ilsacul，于是魂石的 20 秒计时一结束、而剩下的复制体明明还站着，循环就冻住了：
# 复制阶段还在扫 @e[tag=li_pig]，可 timer 已经不再被调用（2026-11-10 车主报的"过一个循环就停"）。
execute if score #state kitpvp.game matches 1 if entity @e[tag=kitpvp.li_pig] run scoreboard players set #li_active kitpvp.game 1
execute if score #li_active kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/timer
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #litimer kitpvp.game 0
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0

# ===== 地球（kit 68）=====
# 技能：召唤生灵。蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一枚"。
# 山羊蛋刷出来的山羊是纯载体，cast 里当场清掉。
execute as @a[scores={kitpvp.kit=68,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.earth_used > @s kitpvp.earth_last run function kitpvp:skill/earth/cast

# 召唤物计时器（都挂在实体上）
execute as @e[scores={kitpvp.earth_cd_a=1..}] run scoreboard players remove @s kitpvp.earth_cd_a 1

# ---- 地球召唤物：从「测试」分支搬过来的 8 只（2026-11-10）----
# 守卫式死亡触发：把隐形 marker 拖到本体身上，本体一没就干活（顺序不能反：先拖再判）
execute as @e[tag=kitpvp.earth_threshold] at @s run tp @e[tag=kitpvp.earth_threshold_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_threshold_guard] at @s unless entity @e[tag=kitpvp.earth_threshold,distance=..3] run function kitpvp:skill/earth/threshold_death
execute as @e[tag=kitpvp.earth_hydrator] at @s run tp @e[tag=kitpvp.earth_hydrator_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_hydrator_guard] at @s unless entity @e[tag=kitpvp.earth_hydrator,distance=..3] run function kitpvp:skill/earth/hydrator_death
# 泄密者：15 秒一次的播报（时钟是独立 marker）
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=1..}] run scoreboard players remove @s kitpvp.leaker_cd 1
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=..0}] at @s run function kitpvp:skill/earth/leaker_tick
# 滑冰者：铺雪 / 滑行音效合成一条每刻扫描（两个计时在函数内部自己判断，省一遍 @e 过滤）
execute as @e[tag=kitpvp.earth_skater] at @s run function kitpvp:skill/earth/skater_tick
# 井盖：2.5 格内有人就弹开
execute as @e[tag=kitpvp.earth_manhole,scores={kitpvp.earth_cd_a=..0}] at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop
# 矿车：40 秒寿命，到点连船带蠹虫自毁；蠹虫没了就顺手清掉孤儿船
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=1..}] run scoreboard players remove @s kitpvp.minecart_life 1
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=..0},tag=!kitpvp.earth_minecart_stopped] at @s run function kitpvp:skill/earth/minecart_stop
execute as @e[type=minecraft:boat,tag=kitpvp.earth_minecart_boat] at @s unless entity @e[type=minecraft:silverfish,tag=kitpvp.earth_minecart,distance=..2] run kill @s
# Dominion：出场计时（只用来决定"出场那阵烟"还要不要补，不控制烟花本身）
execute as @e[tag=kitpvp.earth_dominion] run scoreboard players add @s kitpvp.dominion_age 1
execute as @e[tag=kitpvp.earth_sheep,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/sheep_aura
execute as @e[tag=kitpvp.earth_disruptor,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/disrupt
# 超凡升天：60 刻后开始漂浮，300 刻后离场（tag 区分两个阶段）
execute as @e[tag=kitpvp.earth_levitate,scores={kitpvp.earth_lev=1..}] run scoreboard players remove @s kitpvp.earth_lev 1
execute as @e[tag=kitpvp.earth_levitate,tag=!kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_start
execute as @e[tag=kitpvp.earth_levitate,tag=kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_end
# 跟踪炸弹的小僵尸 6 秒后清除
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=1..}] run scoreboard players remove @s kitpvp.earth_life 1
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=..0}] run kill @s

# 湿海绵船夫：只有还坐在自己的筏上时才有抗性提升 V，下筏 / 沉船就撤掉
execute as @e[tag=kitpvp.earth_boatman1] at @s unless entity @e[tag=kitpvp.earth_boat1,distance=..2] run effect clear @s minecraft:resistance

# 干海绵船夫：船被打掉（2 格内找不到自己的船）→ 一次性给 15 秒力量 II
execute as @e[tag=kitpvp.earth_boatman2,tag=!kitpvp.earth_powered,tag=!kitpvp.earth_power_armed] at @s unless entity @e[tag=kitpvp.earth_boat2,distance=..2] run tag @s add kitpvp.earth_power_armed
execute as @e[tag=kitpvp.earth_power_armed] run effect give @s minecraft:strength 15 1 true
execute as @e[tag=kitpvp.earth_power_armed] run tag @s add kitpvp.earth_powered
execute as @e[tag=kitpvp.earth_power_armed] run tag @s remove kitpvp.earth_power_armed

# 随从：本体（小僵尸）一死，驮着它的悦灵也不该继续飘——2 格内找不到自己的小僵尸就清掉
execute as @e[type=minecraft:allay,tag=kitpvp.earth_retainer_mount] at @s unless entity @e[type=minecraft:zombie,tag=kitpvp.earth_retainer,distance=..2] run kill @s

# 可疑草丛：落地 2 秒后才算蹲好；敌人贴身（半径 1）或血量掉到 20 以下（被打到）就爆开
# 贴身判定按玩家逐个查（见 skill/earth/grass_probe）：主人自己踩上去不算，草丛可以顶着主人走
# popped 是防重入：kill 的移除在下一刻，同一刻几条判定会各调一次 pop，直接变好几只
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped,scores={kitpvp.earth_grass_arm=1..}] run scoreboard players remove @s kitpvp.earth_grass_arm 1
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/earth/grass_probe
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped] store result score @s kitpvp.tmp run data get entity @s Health
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped,scores={kitpvp.tmp=..19}] at @s run function kitpvp:summon/earth_grass_pop

# 黑客死亡播报：本刻存活数比上一刻少 => 刚有黑客被干掉（同一刻掉两只只播一次，够用）
scoreboard players set #hacker_count kitpvp.game 0
execute as @e[tag=kitpvp.earth_hacker] run scoreboard players add #hacker_count kitpvp.game 1
execute if score #state kitpvp.game matches 1 if score #hacker_count kitpvp.game < #hacker_prev kitpvp.game run function kitpvp:summon/earth_hacker_death
scoreboard players operation #hacker_prev kitpvp.game = #hacker_count kitpvp.game

# 召唤蛋补货（自愈口径，同太阳）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=68,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/earth/auto
# 山羊载体兜底清
kill @e[tag=kitpvp.earth_token]

# ===== 炸弹兵（kit 19）/ 里·炸弹兵（kit 32）=====
# 五套令牌共用蘑菇牛蛋，蛋刷出的隐形载体只当落点标记：dispatch 按载体 tag 分流，cast 在它的位置放炸弹再清掉
execute as @a[scores={kitpvp.kit=19,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.bomb_used > @s kitpvp.bomb_last run function kitpvp:skill/bomber/dispatch
execute as @a[scores={kitpvp.kit=32,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.bomb_used > @s kitpvp.bomb_last run function kitpvp:skill/tainted_bomber/dispatch

# 补货：cd 走完才发；满仓时什么都不发、cd 停在 0，等下一枚用掉再起计
execute as @a[scores={kitpvp.kit=19,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/bomber/refill
execute as @a[scores={kitpvp.kit=32,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_bomber/refill

# 补货计时：表四个（小/大/假/跟踪）+ 里三个（大/跟踪/核弹），各算各的、用掉才起计
execute as @a[scores={kitpvp.bomb_small_cd=1..}] run scoreboard players remove @s kitpvp.bomb_small_cd 1
execute as @a[scores={kitpvp.bomb_big_cd=1..}] run scoreboard players remove @s kitpvp.bomb_big_cd 1
execute as @a[scores={kitpvp.bomb_fake_cd=1..}] run scoreboard players remove @s kitpvp.bomb_fake_cd 1
execute as @a[scores={kitpvp.bomb_track_cd=1..}] run scoreboard players remove @s kitpvp.bomb_track_cd 1
execute as @a[scores={kitpvp.bomb_nuke_cd=1..}] run scoreboard players remove @s kitpvp.bomb_nuke_cd 1

# 末影人魂石：用掉蛋就发一把魂石·传送枪
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_ep_used > @s kitpvp.soul_ep_last run function kitpvp:skill/soul/use_ep

# ===== 混沌战士（kit 45）：弓 / 弩 / 三叉戟的"使用"各扣一次 =====
execute as @a[scores={kitpvp.kit=45}] unless score @s kitpvp.chaos_bow_last matches -2147483648.. run scoreboard players operation @s kitpvp.chaos_bow_last = @s kitpvp.chaos_bow_used
execute as @a[scores={kitpvp.kit=45}] unless score @s kitpvp.chaos_xbow_last matches -2147483648.. run scoreboard players operation @s kitpvp.chaos_xbow_last = @s kitpvp.chaos_xbow_used
execute as @a[scores={kitpvp.kit=45}] unless score @s kitpvp.chaos_tri_last matches -2147483648.. run scoreboard players operation @s kitpvp.chaos_tri_last = @s kitpvp.chaos_tri_used
execute as @a[scores={kitpvp.kit=45}] if score @s kitpvp.chaos_bow_used > @s kitpvp.chaos_bow_last run function kitpvp:kit/chaos_shot_bow
execute as @a[scores={kitpvp.kit=45}] if score @s kitpvp.chaos_xbow_used > @s kitpvp.chaos_xbow_last run function kitpvp:kit/chaos_shot_xbow
execute as @a[scores={kitpvp.kit=45}] if score @s kitpvp.chaos_tri_used > @s kitpvp.chaos_tri_last run function kitpvp:kit/chaos_shot_tri
# 混沌重铸：右键令牌（统计 spyglass 使用）→ 清武器并随机重铸，冷却 30 秒
execute as @a[scores={kitpvp.kit=45,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.chaos_skill_used > @s kitpvp.chaos_skill_last run function kitpvp:kit/chaos_skill
# 混沌·金斧：持有时隐身（effect 类被动只能走 tick）
execute as @a[scores={kitpvp.kit=45}] at @s if data entity @s SelectedItem.tag.ChaosInvisible run effect give @s minecraft:invisibility 1 0 true

# ===== 里·末影人（kit 33）/ 末影人魂石：传送枪 =====
# 状态灯只发给"当前有传送枪的人"（里·末影人 或 魂石生效中）
bossbar set kitpvp:tep_hud_orange players @a[scores={kitpvp.kit=33},tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_blue players @a[scores={kitpvp.kit=33},tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_red players @a[tag=kitpvp.soul_ep_active,tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_purple players @a[tag=kitpvp.soul_ep_active,tag=!kitpvp.spectator]
# 使用分发：里·末影人走橙/蓝，魂石走红/紫（快照只推进一次，防止两边抢同一次右键）
execute as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.tep_last matches -2147483648.. run scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
execute as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.tep_used > @s kitpvp.tep_last run function kitpvp:skill/enderman/use_dispatch
# 冷却：里·末影人 2 秒 / 魂石 0.5 秒
execute as @a[scores={kitpvp.tep_cd=1..}] run scoreboard players remove @s kitpvp.tep_cd 1
execute as @a[scores={kitpvp.tep_cd_s=1..}] run scoreboard players remove @s kitpvp.tep_cd_s 1
execute as @a[scores={kitpvp.tep_ready=1..}] run scoreboard players remove @s kitpvp.tep_ready 1
# 末影人魂石：20 秒后收回传送枪并关掉红/紫门
execute as @a[tag=kitpvp.soul_ep_active,scores={kitpvp.soul_ep_timer=1..}] run scoreboard players remove @s kitpvp.soul_ep_timer 1
execute as @a[tag=kitpvp.soul_ep_active,scores={kitpvp.soul_ep_timer=..0}] run function kitpvp:skill/soul/soul_ep_expire
# 门的寿命 / 粒子 / 状态灯
execute as @e[tag=kitpvp.tep_portal] at @s run function kitpvp:skill/enderman/portal_tick
# 玩家穿门（每个人 3 秒免疫；两扇门都齐了才生效）
execute as @e[tag=kitpvp.tep_a] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator] run function kitpvp:skill/enderman/enter_b
execute as @e[tag=kitpvp.tep_b] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator] run function kitpvp:skill/enderman/enter_a
execute as @e[tag=kitpvp.tep_r] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator] run function kitpvp:skill/enderman/enter_p
execute as @e[tag=kitpvp.tep_p] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator] run function kitpvp:skill/enderman/enter_r
# 非玩家实体（召唤物 / 箭 / 掉落物）任何人的门都能穿；装饰类与 marker 不参与
execute as @e[tag=kitpvp.tep_a] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_b
execute as @e[tag=kitpvp.tep_b] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_a
execute as @e[tag=kitpvp.tep_r] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_p
execute as @e[tag=kitpvp.tep_p] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_r
# 实体侧的穿门免疫
execute as @e[type=!minecraft:player,scores={kitpvp.tep_ready=1..}] run scoreboard players remove @s kitpvp.tep_ready 1
execute as @e[tag=kitpvp.bomb_rider,scores={kitpvp.bomb_life=1..}] run scoreboard players remove @s kitpvp.bomb_life 1
execute as @e[tag=kitpvp.bomb_rider,scores={kitpvp.bomb_life=..0}] run kill @s

# 渔夫：无戟计时器，背包无戟持续 160 刻（8 秒）才允许补发，防"投出即补"刷两把
execute as @a[scores={kitpvp.kit=7}] at @s run kill @e[type=minecraft:drowned,distance=..16,name="寻戟"]
scoreboard players add @a[scores={kitpvp.kit=7,kitpvp.alive=1}] kitpvp.fisher_no_tri 1
execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1}] if data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run scoreboard players set @s kitpvp.fisher_no_tri 0

tag @a remove kitpvp.hold_ep_prev
tag @a[tag=kitpvp.hold_ep] add kitpvp.hold_ep_prev
tag @a remove kitpvp.hold_ep
execute as @a if data entity @s SelectedItem.tag.KitEnderPearl run tag @s add kitpvp.hold_ep
execute as @a[scores={kitpvp.kit=8,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.ender_used > @s kitpvp.ender_last run function kitpvp:skill/enderman/cast

execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.fisher_used > @s kitpvp.fisher_last run function kitpvp:skill/fisher/cast
execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.fisher_handout,tag=!kitpvp.spectator] run function kitpvp:skill/fisher/handout

# 狼人 / 驯兽师：都用 wolf_spawn_egg（嗅闻令牌 / 狼蛋），各自靠 EntityTag 认自己那只、按 kit 分闸门，互不触发
execute as @a[scores={kitpvp.kit=18,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.werewolf_used > @s kitpvp.werewolf_last run function kitpvp:skill/werewolf/cast
execute as @a[scores={kitpvp.kit=11,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tamer_used > @s kitpvp.tamer_last run function kitpvp:skill/tamer/cast
# 命中被动的 18 刻（0.9 秒）内置冷却
execute as @a[scores={kitpvp.werewolf_hit_cd=1..}] run scoreboard players remove @s kitpvp.werewolf_hit_cd 1

# 太阳（kit 65）：被动"免疫一切状态效果"每刻清空效果；两个技能各自独立冷却（耀斑看 cd，黑子看 cd2）
execute as @a[scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/passive
# ⚠ 必须带 at @s：耀斑 / 黑子的距离判定与粒子都靠它锚定（tick 本身执行在世界出生点）
# ⚠ 必须带 kit=65：否则别人捡到地上的令牌右键也会真的放出技能（其它职业都有这道闸门）
execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.sun_flare_used > @s kitpvp.sun_flare_last run function kitpvp:skill/sun/flare_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.sun_spot_used > @s kitpvp.sun_spot_last run function kitpvp:skill/sun/spot_cast
# 干扰刷新与 5 秒读秒（挂在中招者身上，中招后死亡也照走完）
execute as @a[tag=kitpvp.sun_flare] at @s run function kitpvp:skill/sun/flare_tick
# 令牌补货：只在游戏进行中补（不然大厅里也会发令牌）；handout 模型一旦有非施法路径的丢失就永远补不回来
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=65,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/sun/refill_flare
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=65,kitpvp.alive=1,kitpvp.cd2=0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/sun/refill_spot
# 令牌刷出的蜜蜂 / 蝙蝠就地清掉（distance 16 覆盖刷怪蛋右键射程；只认 EntityTag 的 tag，不误伤野生的）
execute as @a[scores={kitpvp.kit=65}] at @s run kill @e[tag=kitpvp.sun_flare_token,distance=..16]
execute as @a[scores={kitpvp.kit=65}] at @s run kill @e[tag=kitpvp.sun_spot_token,distance=..16]

# 魂石：右键对应的刷怪蛋 → used 增长 → 触发一次性效果（共用蛋的类型要经过 dispatch 分流）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_warrior_used > @s kitpvp.soul_warrior_last run function kitpvp:skill/soul/dispatch_warrior
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_archer_used > @s kitpvp.soul_archer_last run function kitpvp:skill/soul/use_archer
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_pirate_used > @s kitpvp.soul_pirate_last run function kitpvp:skill/soul/use_pirate
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_fisher_used > @s kitpvp.soul_fisher_last run function kitpvp:skill/soul/use_fisher
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_zombie_used > @s kitpvp.soul_zombie_last run function kitpvp:skill/soul/use_zombie
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_earth_used > @s kitpvp.soul_earth_last run function kitpvp:skill/soul/use_earth
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_li_used > @s kitpvp.soul_li_last run function kitpvp:skill/soul/use_li
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_slime_used > @s kitpvp.soul_slime_last run function kitpvp:skill/soul/use_slime
# 魂石：驯兽师 / 太阳 / 水星 / 金星（水星是一次性 buff，没有后续计时）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_tamer_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_tamer_last = @s kitpvp.soul_tamer_used
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_tamer_used > @s kitpvp.soul_tamer_last run function kitpvp:skill/soul/use_tamer
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_sun_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_sun_last = @s kitpvp.soul_sun_used
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_sun_used > @s kitpvp.soul_sun_last run function kitpvp:skill/soul/use_sun
# 水星魂石走 advancement（advancements/player/soul_mercury_use.json），不再用「海豚蛋被使用」统计
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_venus_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_venus_used > @s kitpvp.soul_venus_last run function kitpvp:skill/soul/use_venus
# 驯兽师 / 太阳：落点 marker 的每刻推进；金星：舔狗自己的 20 秒计时与增益
execute as @e[tag=kitpvp.soul_tamer_marker] at @s run function kitpvp:skill/soul/tamer_tick
execute as @e[tag=kitpvp.soul_sun_marker] at @s run function kitpvp:skill/soul/sun_tick
execute as @e[tag=kitpvp.soul_venus_dog] at @s run function kitpvp:skill/soul/venus_tick

# 地球魂石：标记处每 10 刻召一只（earth_cd_a 已由上面的实体计时器统一递减）
execute as @e[tag=kitpvp.soul_earth_marker,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/soul/earth_step

# 僵尸魂石：20 秒到就摘掉 +20 上限
execute as @a[tag=kitpvp.soul_zombie_active,scores={kitpvp.soul_zombie_timer=1..}] run scoreboard players remove @s kitpvp.soul_zombie_timer 1
execute as @a[tag=kitpvp.soul_zombie_active,scores={kitpvp.soul_zombie_timer=..0}] run function kitpvp:skill/soul/zombie_expire

# 史莱姆魂石：只读秒，增益由 slime_apply 一次性发 20 秒（不每刻补）
execute as @a[tag=kitpvp.soul_slime_active,scores={kitpvp.soul_slime_timer=1..}] run scoreboard players remove @s kitpvp.soul_slime_timer 1
execute as @a[tag=kitpvp.soul_slime_active,scores={kitpvp.soul_slime_timer=..0}] run function kitpvp:skill/soul/slime_expire

# 里·史莱姆 / 史莱姆魂石：蓄力火箭跳（tag 由 kit/tainted_slime 与 soul/slime_apply 挂上；大厅里也跑，选完职业就能试）
execute as @a[tag=kitpvp.rocket_jump,scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_slime/charge

# 史莱姆魂石的常驻 III：落地清空 / 蓄力顶掉后，缺了才补 1 秒（到期 tag 摘掉后就不再补）
execute as @a[tag=kitpvp.soul_slime_active,scores={kitpvp.soul_slime_timer=1..}] unless predicate kitpvp:has_jump_boost run effect give @s minecraft:jump_boost 1 2 true

# 自动技能统一入口（按 kit 分派；主动技能与触发器驱动技能不走这里）
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch

execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=1..}] run scoreboard players remove @s kitpvp.soul_bow_timer 1
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=..0}] run function kitpvp:skill/soul/bow_expire
execute as @a[tag=kitpvp.soul_pirate_held,scores={kitpvp.soul_pirate_timer=1..}] run scoreboard players remove @s kitpvp.soul_pirate_timer 1
execute as @a[tag=kitpvp.soul_pirate_held,scores={kitpvp.soul_pirate_timer=..0}] run function kitpvp:skill/soul/pirate_expire
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_ghost_used > @s kitpvp.soul_ghost_last run function kitpvp:skill/soul/use_ghost
execute as @a[scores={kitpvp.soul_ghost_timer=1..}] run scoreboard players remove @s kitpvp.soul_ghost_timer 1
execute as @a[tag=kitpvp.soul_ghost_active,scores={kitpvp.soul_ghost_timer=..0}] run function kitpvp:skill/soul/ghost_expire
# 渔夫魂石：计时两段（380 落「无量空渔」、0 收束）与到期回收都在 soul/fisher_tick 里；带 at @s 供粒子锚定
execute as @a[tag=kitpvp.soul_fisher_active] at @s run function kitpvp:skill/soul/fisher_tick
execute as @a[scores={kitpvp.ghost_minion_cd=1..}] run scoreboard players remove @s kitpvp.ghost_minion_cd 1

# 无敌 / 虚空 / 死亡
scoreboard players add @a kitpvp.inv 0
execute as @a[scores={kitpvp.inv=1..}] run scoreboard players remove @s kitpvp.inv 1
execute as @a[tag=kitpvp.invincible,scores={kitpvp.inv=0}] run function kitpvp:player/end_invincible
# 虚空兜底：y=-1024 配 dy=950 覆盖 y ∈ [-1024,-74]；改阈值只改 dy
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world
execute as @a[tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch
# 死亡检测落在死亡那一 tick，但重生由客户端重生包驱动、要晚至少 1 刻，且重生会清空全部药水效果。
# 所以必须等 Health 归位（真正重生完成）再挂无敌与被动，否则等于没挂（见 04 第六节）。
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] unless entity @s[nbt={Health:0.0f}] run function kitpvp:player/after_death

# 胜负判定：必须排在死亡处理之后——同刻互杀要等两人都淘汰完再统计，
# 否则会先看到"幸存者=1"而误判胜者；同时覆盖掉线减员的兜底
execute if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner
# ===== 多伦多：矿车按钮（advancement 之外的第二道判定：看按钮 powered 状态） =====
execute if score #cart_cd1 kitpvp.game matches 1.. run scoreboard players remove #cart_cd1 kitpvp.game 1
execute if score #cart_cd1 kitpvp.game matches ..0 if block 5963 65 6054 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_1
execute if score #cart_cd2 kitpvp.game matches 1.. run scoreboard players remove #cart_cd2 kitpvp.game 1
execute if score #cart_cd2 kitpvp.game matches ..0 if block 5972 65 6004 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_2
execute if score #cart_cd3 kitpvp.game matches 1.. run scoreboard players remove #cart_cd3 kitpvp.game 1
execute if score #cart_cd3 kitpvp.game matches ..0 if block 5976 65 5966 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_3
execute if score #cart_cd4 kitpvp.game matches 1.. run scoreboard players remove #cart_cd4 kitpvp.game 1
execute if score #cart_cd4 kitpvp.game matches ..0 if block 5987 65 6046 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_4
execute if score #cart_cd5 kitpvp.game matches 1.. run scoreboard players remove #cart_cd5 kitpvp.game 1
execute if score #cart_cd5 kitpvp.game matches ..0 if block 6006 65 5977 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_5
execute if score #cart_cd6 kitpvp.game matches 1.. run scoreboard players remove #cart_cd6 kitpvp.game 1
execute if score #cart_cd6 kitpvp.game matches ..0 if block 6012 74 5988 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_6
execute if score #cart_cd7 kitpvp.game matches 1.. run scoreboard players remove #cart_cd7 kitpvp.game 1
execute if score #cart_cd7 kitpvp.game matches ..0 if block 6023 65 6046 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_7
execute if score #cart_cd8 kitpvp.game matches 1.. run scoreboard players remove #cart_cd8 kitpvp.game 1
execute if score #cart_cd8 kitpvp.game matches ..0 if block 6037 65 6005 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_8
execute if score #cart_cd9 kitpvp.game matches 1.. run scoreboard players remove #cart_cd9 kitpvp.game 1
execute if score #cart_cd9 kitpvp.game matches ..0 if block 6049 65 5962 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_9
execute if score #cart_cd10 kitpvp.game matches 1.. run scoreboard players remove #cart_cd10 kitpvp.game 1
execute if score #cart_cd10 kitpvp.game matches ..0 if block 6049 65 6014 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_10
execute if score #cart_cd11 kitpvp.game matches 1.. run scoreboard players remove #cart_cd11 kitpvp.game 1
execute if score #cart_cd11 kitpvp.game matches ..0 if block 6050 65 6054 minecraft:stone_button[powered=true] run function kitpvp:map/toronto/cart_11
