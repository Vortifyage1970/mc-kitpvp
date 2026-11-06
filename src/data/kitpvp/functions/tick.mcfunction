# 自检探针：每刻 +1。debug/selfcheck 会读它 —— 数值在涨就说明 tick 在跑，而且跑的是这一版代码
scoreboard players add #tick_probe kitpvp.game 1

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
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾令牌"]
# 令牌只在"真的用过"（cast 开的窗口）且冷却走完时发回，不拿"背包里没有"当依据（见 04 §四）
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.tank_handout,tag=!kitpvp.spectator] run function kitpvp:skill/tank/handout

# 箭一落地即清，防"射出→换弹→捡回"刷过上箭上限。必须每刻轮询：20 刻一次的话，落地到清理之间有窗口能捡回
# 只有场上存在用箭职业时才扫描；tag kitpvp.arrow_user 由 kit/archer 与 kit/tainted_archer 打上（见 04 §五）
execute if entity @a[tag=kitpvp.arrow_user] run kill @e[type=minecraft:arrow,nbt={inGround:1b}]

execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin/dispatch
execute as @a[scores={kitpvp.cd=..500},tag=kitpvp.assassin_hidden,tag=!kitpvp.spectator] run function kitpvp:skill/assassin/unhide
execute as @a[scores={kitpvp.kit=4}] at @s run kill @e[type=enderman,distance=..16,name="隐匿令牌"]
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
# 地球·53 金星（狐狸）：常驻冷气，复用下面 coldness 那套（+1/-1/封顶/上药）
execute as @e[tag=kitpvp.earth_venus] at @s run function kitpvp:skill/earth/venus_chill_mark
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
execute if score #state kitpvp.game matches 1 if entity @e[tag=kitpvp.earth_ilsacul] run scoreboard players set #li_active kitpvp.game 1
# 李朱俊泽魂石：计时开关（#li_soul 由 li_apply 置 400，20 秒后 li_expire 归一），与场上有没有 kit=88 无关
execute if score #li_soul kitpvp.game matches 1.. run scoreboard players set #li_active kitpvp.game 1
execute if score #li_soul kitpvp.game matches 1.. run scoreboard players remove #li_soul kitpvp.game 1
execute if score #li_soul kitpvp.game matches 0 run function kitpvp:skill/soul/li_expire
execute if score #li_active kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/timer
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #litimer kitpvp.game 0
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0

# ===== 地球（kit 68）=====
# 技能：召唤生灵。蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一枚"。
# 山羊蛋刷出来的山羊是纯载体，cast 里当场清掉。
execute as @a[scores={kitpvp.kit=68,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.earth_used > @s kitpvp.earth_last run function kitpvp:skill/earth/cast

# 召唤物计时器（都挂在实体上）
execute as @e[scores={kitpvp.earth_cd_a=1..}] run scoreboard players remove @s kitpvp.earth_cd_a 1
execute as @e[tag=kitpvp.earth_sheep,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/sheep_aura
execute as @e[tag=kitpvp.earth_disruptor,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/disrupt
# 变速器：6 格内没别人就提速，有敌人就变肉变慢并给急迫（判定与效果都在 gearbox_aura 里）
execute as @e[tag=kitpvp.earth_gearbox,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/gearbox_aura
# 大蜜蜂：半径 10 格内的所有玩家和生物持续挖掘疲劳 III
# 每刻直接跑、不再用 scores 节流：分数不存在时那个选择器不匹配，整条会静默失效（踩过一次）
execute as @e[tag=kitpvp.earth_bigbee] at @s run function kitpvp:skill/earth/bigbee_aura
# 大蜜蜂减速提示音的冷却：统一在 tick 减一次，避免多只蜜蜂各减一遍
execute as @a[scores={kitpvp.bee_slow_snd=1..}] run scoreboard players remove @s kitpvp.bee_slow_snd 1

# 地球·54 电磁炮：每刻找目标、充能、充满就放电（充能计数在 sparky_tick 里维护）
execute as @e[tag=kitpvp.earth_sparky] at @s run function kitpvp:skill/earth/sparky_tick
# 木星：本体不驮乘客（armor_stand 当乘客不可靠），改由脚下那枚隐形 marker 守卫跟着它走
# 顺序不能反：先把守卫拖到木星身上，再判"3 格内还有没有木星" —— 反过来守卫会在被传送时误劈
execute as @e[tag=kitpvp.earth_jupiter] at @s run tp @e[tag=kitpvp.earth_jupiter_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_jupiter_guard] at @s unless entity @e[tag=kitpvp.earth_jupiter,distance=..3] run function kitpvp:skill/earth/jupiter_death
# 门槛哥：脚下的隐形 marker 跟着走，本体一没了就在原地立一扇门（顺序不能反，先拖后判）
execute as @e[tag=kitpvp.earth_threshold] at @s run tp @e[tag=kitpvp.earth_threshold_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_threshold_guard] at @s unless entity @e[tag=kitpvp.earth_threshold,distance=..3] run function kitpvp:skill/earth/threshold_death
# 补水兵：守卫每刻被拖到本体脚下，本体一消失就在原地灌水（砍死 / 烧死 / /kill 都会触发）
execute as @e[tag=kitpvp.earth_hydrator] at @s run tp @e[tag=kitpvp.earth_hydrator_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_hydrator_guard] at @s unless entity @e[tag=kitpvp.earth_hydrator,distance=..3] run function kitpvp:skill/earth/hydrator_death
# 资本家：守卫每刻被拖到本体脚下，本体一消失就在原地掉一张十万大刀乐
execute as @e[tag=kitpvp.earth_capitalist] at @s run tp @e[tag=kitpvp.earth_capitalist_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_capitalist_guard] at @s unless entity @e[tag=kitpvp.earth_capitalist,distance=..3] run function kitpvp:skill/earth/capitalist_death
# 借调员工：冷却递减 → 玩家挨打时抢锅 → 每 30 秒自己认领一件不相干的事 → 守卫跟随 → 本体没了掉解雇通知
# 泄露者：播报时钟递减；到点由 leaker_tick 从【还活着的那三个】里随机抽一个名字通报
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=1..}] run scoreboard players remove @s kitpvp.leaker_cd 1
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=..0}] at @s run function kitpvp:skill/earth/leaker_tick
# 双星：两只各带一个隐形 marker，本体没了就各自排 2 秒后的"复活还是放走"检查（先拖后判）
execute as @e[tag=kitpvp.earth_twinstar_a] at @s run tp @e[tag=kitpvp.earth_twinstar_guard_a,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_twinstar_guard_a] at @s unless entity @e[tag=kitpvp.earth_twinstar_a,distance=..3] run function kitpvp:skill/earth/twinstar_died_a
execute as @e[tag=kitpvp.earth_twinstar_b] at @s run tp @e[tag=kitpvp.earth_twinstar_guard_b,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_twinstar_guard_b] at @s unless entity @e[tag=kitpvp.earth_twinstar_b,distance=..3] run function kitpvp:skill/earth/twinstar_died_b
# COSER：玩家刚挨打的那一帧（HurtTime=9）且 32 格内有 COSER，就给一张「物料」（箭伤同样触发）
execute as @a[nbt={HurtTime:9s},gamemode=!spectator,tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.earth_coser,distance=..32] run function kitpvp:skill/earth/coser_paper
# COSER 猫叫：每 4 秒一声（计时在 summon 里埋初值、函数里重置）
execute as @e[tag=kitpvp.earth_coser,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/coser_meow
# ★ 不用"读尸体 Health=0 那一帧"：实测被 /damage 打死的木星在第 1 刻就整个不见了，那一帧抓不到
# ★ /kill 也照样炸（守卫只看木星在不在，不看怎么死的）；只有 game/reset 例外，它先删守卫再删木星
# ★ 已知瑕疵：两只木星靠得极近（6 格内）时会共用一枚守卫，靠得远的那只死时不劈

# 动员家：每 15 秒（300 刻）催一次"准备"，5 秒后没人点就挨瞬间伤害（结算在 mobilizer_check）
# 守卫与木星同一套：先拖到本体身上，再判"3 格内还有没有本体"，没了就播红色的"结束准备"
execute as @e[tag=kitpvp.earth_mobilizer] at @s run tp @e[tag=kitpvp.earth_mobilizer_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_mobilizer_guard] at @s unless entity @e[tag=kitpvp.earth_mobilizer,distance=..3] run function kitpvp:skill/earth/mobilizer_end
execute as @e[tag=kitpvp.earth_mobilizer,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/mobilizer_prompt
# 滑冰者：每秒在脚下铺一格细雪（10 秒后自化），本体是 stray 所以自己不怕冻
execute as @e[tag=kitpvp.earth_skater,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/skater_ice
# 滑冰者：滑行音效的计时（单独一个分，铺雪用 earth_cd_a 每 5 刻一次，不能共用）
execute as @e[tag=kitpvp.earth_skater,scores={kitpvp.skater_snd=1..}] run scoreboard players remove @s kitpvp.skater_snd 1
execute as @e[tag=kitpvp.earth_skater,scores={kitpvp.skater_snd=..0}] at @s run function kitpvp:skill/earth/skater_skate
# 交警：先把每个玩家的"这一刻速度"算成分（位移 x+z，格/刻 x100），再让跑得够快的人被贴脸
execute as @a run function kitpvp:skill/earth/cop_blink_track
execute as @e[tag=kitpvp.earth_cop_blink] at @s run scoreboard players remove @s kitpvp.earth_cd_a 1
execute as @e[tag=kitpvp.earth_cop_blink,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/cop_blink_jaunt
# 深池飞行兵：蠹虫无敌、僵尸能被杀 —— 僵尸一没，蠹虫跟着自尽（kill 无视 Invulnerable）
execute as @e[tag=kitpvp.earth_dublinn] at @s unless entity @e[type=minecraft:zombie,tag=kitpvp.earth_dublinn_zombie,distance=..3] run kill @s
# 无重力召唤物（无重力僵尸、深池飞行兵）：自己不会走，靠 nograv_chase 每刻 tp 拖着追人
# 深池飞行兵：乘客僵尸被骑着挥不了刀，每 10 刻替它打一下（冷却分在 summon 里埋了初值）
execute as @e[tag=kitpvp.earth_dublinn] at @s run scoreboard players remove @s kitpvp.earth_cd_a 1
execute as @e[tag=kitpvp.earth_dublinn,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/dublinn_strike
# 深池跟着跑的时候也要"盯着"目标：乘客僵尸面朝 12 格内最近的可攻击玩家（tp 原地只改朝向）
execute as @e[tag=kitpvp.earth_dublinn_zombie] at @s facing entity @p[distance=..12,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest] feet run tp @s ~ ~ ~ ~ ~
function kitpvp:skill/earth/nograv_chase

# 环肽（地球·47，实验）：整圈每刻贴到最近的活玩家周围；#ring_spin=1 时四方位轮换（绕圈），=0 就固定方位跟着走
execute if entity @e[tag=kitpvp.earth_cyclic] run function kitpvp:skill/earth/ring_follow
# 预言家：每 15 秒开口（靠 earth_cd_a 归零触发）
execute as @e[tag=kitpvp.earth_oracle,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/oracle_speak
# 磁铁：每刻吸掉落物、拽靠近的玩家
execute if entity @e[tag=kitpvp.earth_magnet] run function kitpvp:skill/earth/magnet_pull
# 内卫：每 3 秒放一枚黑色烟花
execute as @e[tag=kitpvp.earth_dominion,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/dominion_firework
execute as @e[tag=kitpvp.earth_dominion] run scoreboard players add @s kitpvp.dominion_age 1
# 变色者：每 5 秒换一次头顶方块（earth_cd_a 由 tick 统一递减）
execute as @e[tag=kitpvp.earth_colorchanger,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/colorchanger_shift
# 井盖：装填期（earth_cd_a，召唤后 2 秒）走完之后，头顶 2.5 格内有活人就破土（dy≈2 ⇒ 站在正上方即命中）
execute as @e[tag=kitpvp.earth_manhole,scores={kitpvp.earth_cd_a=..0}] at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop
# 篝火：挨打就点燃。判据是"血量变少了"（每刻读一次 Health×100 与上一帧比）—— 比 nbt HurtTime 靠谱，任何来源的掉血都算
execute as @e[tag=kitpvp.earth_campfire] store result score @s kitpvp.fire_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=..0}] if score @s kitpvp.fire_hp < @s kitpvp.fire_prev run function kitpvp:skill/earth/campfire_ignite
execute as @e[tag=kitpvp.earth_campfire] run scoreboard players operation @s kitpvp.fire_prev = @s kitpvp.fire_hp
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=1..}] run scoreboard players remove @s kitpvp.fire_left 1
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=0}] at @s run function kitpvp:skill/earth/campfire_out
# 燃烧中每刻冒火苗（NBT 的 Fire 只是让它真的着火，这里补粒子让"在烧"一眼可见）
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=1..}] at @s run particle minecraft:flame ~ ~1.2 ~ 0.35 0.5 0.35 0.01 4
# 音符盒：血量掉了 = 挨打了 ⇒ 打一个随机音符（6 刻冷却，连击不会糊成一片）
execute as @e[tag=kitpvp.earth_noteblock] store result score @s kitpvp.nb_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_noteblock,scores={kitpvp.earth_cd_a=..0}] if score @s kitpvp.nb_hp < @s kitpvp.nb_prev run function kitpvp:skill/earth/noteblock_note
execute as @e[tag=kitpvp.earth_noteblock] run scoreboard players operation @s kitpvp.nb_prev = @s kitpvp.nb_hp
execute as @e[tag=kitpvp.earth_noteblock] at @s run tp @e[tag=kitpvp.earth_noteblock_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_noteblock_guard] at @s unless entity @e[tag=kitpvp.earth_noteblock,distance=..3] run function kitpvp:skill/earth/noteblock_death

# 术战士 / 流浪汉的"打中人"结算：不再走 advancement（那套 NBT 条件在这个版本上一直没触发过），
# 改成抓挨打那一帧（HurtTime 9 = 伤害刚结算完的下一个 tick），再看身边 3 格内有没有对应的召唤物
# 误判：被别的僵尸蹭一下、同时 3 格内正好站着一只术战士/流浪汉也会算数（单人自测就用这个特性）
execute as @a[nbt={HurtTime:9s},gamemode=!spectator,tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.earth_spellblade,distance=..3] run function kitpvp:skill/earth/spellblade_hit
execute as @a[nbt={HurtTime:9s},gamemode=!spectator,tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.earth_vagrant,distance=..3] run function kitpvp:skill/earth/vagrant_hit
# 勺子：玩家挨打那一帧、1.6 格内贴着一只勺子，就把主手的物品塞进背包（判定的是"勺子打人"，不是"勺子被打"）
execute as @a[nbt={HurtTime:9s},gamemode=!spectator,tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.earth_spoon,distance=..1.5] run function kitpvp:skill/earth/spoon_hit
# 交警：矿车只是出场载具，200 刻（10 秒）到点撤掉，人自己落地继续走
execute as @e[tag=kitpvp.earth_cop_cart,scores={kitpvp.earth_cd_a=..0}] run kill @s
# 超凡升天：60 刻后开始漂浮，300 刻后离场（tag 区分两个阶段）
execute as @e[tag=kitpvp.earth_levitate,scores={kitpvp.earth_lev=1..}] run scoreboard players remove @s kitpvp.earth_lev 1
execute as @e[tag=kitpvp.earth_levitate,tag=!kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_start
execute as @e[tag=kitpvp.earth_levitate,tag=kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_end
# 跟踪炸弹的小僵尸 6 秒后清除
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=1..}] run scoreboard players remove @s kitpvp.earth_life 1
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=..0}] run kill @s
# Ollama：每刻把血量存成分数（x10 保精度），比上一次低就是挨打了 → 聊天框一行 ollama run
execute as @e[tag=kitpvp.earth_ollama] store result score @s kitpvp.earth_hp_new run data get entity @s Health 10
execute as @e[tag=kitpvp.earth_ollama] if score @s kitpvp.earth_hp_new < @s kitpvp.earth_hp run function kitpvp:skill/earth/ollama_cry
execute as @e[tag=kitpvp.earth_ollama] run scoreboard players operation @s kitpvp.earth_hp = @s kitpvp.earth_hp_new
# 流浪汉的细雪：marker 计时到点，把那格细雪还成空气（只有还是细雪才收，玩家换过就跳过）
execute as @e[tag=kitpvp.earth_snow,scores={kitpvp.earth_snow=1..}] run scoreboard players remove @s kitpvp.earth_snow 1
execute as @e[tag=kitpvp.earth_snow,scores={kitpvp.earth_snow=..0}] at @s run function kitpvp:skill/earth/snow_clear

# 湿海绵船夫：只有还坐在自己的筏上时才有抗性提升 V，下筏 / 沉船就撤掉
execute as @e[tag=kitpvp.earth_boatman1] at @s unless entity @e[tag=kitpvp.earth_boat1,distance=..2] run effect clear @s minecraft:resistance

# 干海绵船夫：船被打掉（2 格内找不到自己的船）→ 一次性给 15 秒力量 II
execute as @e[tag=kitpvp.earth_boatman2,tag=!kitpvp.earth_powered,tag=!kitpvp.earth_power_armed] at @s unless entity @e[tag=kitpvp.earth_boat2,distance=..2] run tag @s add kitpvp.earth_power_armed
execute as @e[tag=kitpvp.earth_power_armed] run effect give @s minecraft:strength 15 1 true
execute as @e[tag=kitpvp.earth_power_armed] run tag @s add kitpvp.earth_powered
execute as @e[tag=kitpvp.earth_power_armed] run tag @s remove kitpvp.earth_power_armed

# 随从：本体（小僵尸）一死，驮着它的悦灵也不该继续飘——2 格内找不到自己的小僵尸就清掉
execute as @e[type=minecraft:allay,tag=kitpvp.earth_retainer_mount] at @s unless entity @e[type=minecraft:zombie,tag=kitpvp.earth_retainer,distance=..2] run kill @s

# 矿车：蠹虫一死，它背上那条船会掉在地上——2 格内找不到自己的蠹虫就把船清掉
# 矿车跑满 45 秒就熄火：先倒计时，到 0 调 minecart_stop（stopped 标签防止每刻重复触发）
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=1..}] run scoreboard players remove @s kitpvp.minecart_life 1
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=..0},tag=!kitpvp.earth_minecart_stopped] at @s run function kitpvp:skill/earth/minecart_stop
execute as @e[type=minecraft:boat,tag=kitpvp.earth_minecart_boat] at @s unless entity @e[type=minecraft:silverfish,tag=kitpvp.earth_minecart,distance=..2] run kill @s

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

# 渔夫：无戟计时器，背包无戟持续 160 刻（8 秒）才允许补发，防"投出即补"刷两把
execute as @a[scores={kitpvp.kit=7}] at @s run kill @e[type=minecraft:drowned,distance=..16,name="寻戟令牌"]
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

# 地球魂石：标记处每 10 刻召一只（earth_cd_a 已由上面的实体计时器统一递减）
execute as @e[tag=kitpvp.soul_earth_marker,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/soul/earth_step

# 僵尸魂石：20 秒到就摘掉 +20 上限
execute as @a[tag=kitpvp.soul_zombie_active,scores={kitpvp.soul_zombie_timer=1..}] run scoreboard players remove @s kitpvp.soul_zombie_timer 1
execute as @a[tag=kitpvp.soul_zombie_active,scores={kitpvp.soul_zombie_timer=..0}] run function kitpvp:skill/soul/zombie_expire

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
