# 坦克：令牌与魂石共用 iron_golem_spawn_egg，靠 CustomName 分流（skill/tank_dispatch）
# 到期用 ..300 而非 =300：跳刻时不漏触发
execute as @a[scores={kitpvp.cd=..300},tag=kitpvp.shield_held,tag=!kitpvp.spectator] run function kitpvp:skill/tank/expire
# distance 16 覆盖刷怪蛋右键射程；会误杀该范围内同名的装饰性生物
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾"]
# 令牌只在"真的用过"（cast 开的窗口）且冷却走完时发回，不拿"背包里没有"当依据（见 04 §四）

# 箭一落地即清，防"射出→换弹→捡回"刷过上箭上限。必须每刻轮询：20 刻一次的话，落地到清理之间有窗口能捡回
# 只有场上存在用箭职业时才扫描；tag kitpvp.arrow_user 由 kit/archer 与 kit/tainted_archer 打上（见 04 §五）
execute if entity @a[tag=kitpvp.arrow_user] run kill @e[type=minecraft:arrow,nbt={inGround:1b}]

execute as @a[scores={kitpvp.cd=..500},tag=kitpvp.assassin_hidden,tag=!kitpvp.spectator] run function kitpvp:skill/assassin/unhide
execute as @a[scores={kitpvp.kit=4}] at @s run kill @e[type=enderman,distance=..16,name="隐匿"]

# 海盗：射击即进冷却——检测"手持的手炮从已装填翻到未装填"
# Charged 是字节，射击后键还在、值变 0b，所以必须取"值"（判路径会把 0b 也算成已装填）
tag @a remove kitpvp.pirate_charged_prev
tag @a[tag=kitpvp.pirate_charged] add kitpvp.pirate_charged_prev
tag @a remove kitpvp.pirate_charged
scoreboard players set @a[scores={kitpvp.kit=9}] kitpvp.tmp 0
execute as @a[scores={kitpvp.kit=9}] if data entity @s SelectedItem.tag.KitCrossbow store result score @s kitpvp.tmp run data get entity @s SelectedItem.tag.Charged
execute as @a[scores={kitpvp.kit=9,kitpvp.tmp=1..}] run tag @s add kitpvp.pirate_charged
execute as @a[tag=kitpvp.pirate_charged_prev,tag=!kitpvp.pirate_charged,scores={kitpvp.kit=9,kitpvp.alive=1},tag=!kitpvp.spectator] if data entity @s SelectedItem.tag.KitCrossbow run function kitpvp:skill/pirate/fire

# 里·弓箭手：炮台回血被动 / 熔火计时（令牌的补货已移到 slow2: skill/tainted_archer/refill_tokens，排在 use-cast 之后防秒补）
# ⚠ 必须带 at @s：tick 函数的执行位置是世界出生点，技能里所有 ~ 相对坐标都靠这一步锚定
# 炮台回血被动（石斧击打自己的炮台）的 1 秒冷却
execute as @a[scores={kitpvp.turret_heal_cd=1..}] run scoreboard players remove @s kitpvp.turret_heal_cd 1
# 炮台熔火形态：只在使用瞬间变一次（core_fire），之后各自计时 30 秒，计时归零就复原
execute as @e[tag=kitpvp.turret_molten,scores={kitpvp.turret_molten_timer=1..}] run scoreboard players remove @s kitpvp.turret_molten_timer 1
execute as @e[tag=kitpvp.turret_molten,scores={kitpvp.turret_molten_timer=..0}] run function kitpvp:skill/tainted_archer/turret_from_molten

# 里·渔夫（kit 29）：两个令牌，cd / cd2 互为对方的锁（放苍两个都锁 45 秒，放领域展开都锁 240 秒）
# ⚠ 必须带 at @s：水球球心与距离判定都靠它锚定
# 计时排在 cast 之后：cast 写进去的计时器下一刻才该开始走
execute as @a[tag=kitpvp.tainted_fisher_cang] at @s run function kitpvp:skill/tainted_fisher/cang_tick
execute as @a[tag=kitpvp.tainted_fisher_domain] at @s run function kitpvp:skill/tainted_fisher/domain_tick
# 令牌发回：只认"技能刚放完、整把锁走完"的窗口（04 §四：不能改成"背包里没有就补"）
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
