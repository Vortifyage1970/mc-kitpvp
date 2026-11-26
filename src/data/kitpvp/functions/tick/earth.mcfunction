# ===== 地球（kit 68）=====
# 技能：召唤生灵。蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一枚"。
# 山羊蛋刷出来的山羊是纯载体，cast 里当场清掉。
execute as @a[scores={kitpvp.kit=68,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.earth_used > @s kitpvp.earth_last run function kitpvp:skill/earth/cast

# 召唤物计时器（都挂在实体上）
execute as @e[scores={kitpvp.earth_cd_a=1..}] run scoreboard players remove @s kitpvp.earth_cd_a 1

# 地球召唤物的常驻光环 / 计时（merge main 时这几行被整块去重过一次，补回来）
execute as @e[tag=kitpvp.earth_sheep,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/sheep_aura
execute as @e[tag=kitpvp.earth_disruptor,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/disrupt
# 变速器：6 格内没别人就提速，有敌人就变肉变慢并给急迫（判定与效果都在 gearbox_aura 里）
execute as @e[tag=kitpvp.earth_gearbox,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/gearbox_aura
# 大蜜蜂：半径 10 格内的所有玩家和生物持续挖掘疲劳 III（每刻直接跑，别用 scores 节流）
execute as @e[tag=kitpvp.earth_bigbee] at @s run function kitpvp:skill/earth/bigbee_aura
# 大蜜蜂减速提示音的冷却：统一在 tick 减一次，避免多只蜜蜂各减一遍
execute as @a[scores={kitpvp.bee_slow_snd=1..}] run scoreboard players remove @s kitpvp.bee_slow_snd 1
# 内卫：出场计时（只用来决定"出场那阵烟"还要不要补，不控制烟花本身；烟花由 summon 放一次）
execute as @e[tag=kitpvp.earth_dominion] run scoreboard players add @s kitpvp.dominion_age 1
# 地球·54 电磁炮：每刻找目标、充能、充满就放电（充能计数在 sparky_tick 里维护）
execute as @e[tag=kitpvp.earth_sparky] at @s run function kitpvp:skill/earth/sparky_tick
# 地球·70 迫击炮：earth_cd_a 归零就朝 15 格内最近的敌人打一发鱼弹（冷却分在 summon 里埋了初值）
execute as @e[tag=kitpvp.earth_mortar,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/mortar_tick
# 迫击炮的鱼弹：抛物线飞行 + 落地/贴身引爆
execute as @e[tag=kitpvp.mo_shell] at @s run function kitpvp:skill/earth/mortar_shell_tick
# 反装甲步兵：装填/开炮状态机 + 它的高速炮弹
# 地球·79 土星：绕身的「轨道」蠹虫先推相位再摆位置（8 格一圈，每 4 刻一格 = 32 刻绕一圈）
scoreboard players add #sat_clock kitpvp.game 1
execute if score #sat_clock kitpvp.game matches 4.. run scoreboard players add @e[tag=kitpvp.sat_orbit] kitpvp.sat_phase 1
execute if score #sat_clock kitpvp.game matches 4.. run scoreboard players set #sat_clock kitpvp.game 0
execute as @e[tag=kitpvp.sat_orbit,scores={kitpvp.sat_phase=8..}] run scoreboard players remove @s kitpvp.sat_phase 8
execute as @e[tag=kitpvp.sat_orbit] unless score @s kitpvp.sat_phase matches -2147483648.. run scoreboard players set @s kitpvp.sat_phase 0
execute as @e[tag=kitpvp.earth_saturn] at @s run function kitpvp:skill/earth/saturn_tick
execute as @e[tag=kitpvp.sat_orbit] at @s unless entity @e[tag=kitpvp.earth_saturn,distance=..8] run kill @s
# 地球·80 冥王星：头顶的鹦鹉一死，隐形尸壳跟着倒；尸壳先没的话别把鹦鹉留成孤儿（鹦鹉钉在 2.5 格高，判定半径要放宽到 4）
execute as @e[tag=kitpvp.earth_pluto_carrier] at @s run function kitpvp:skill/earth/pluto_tick
execute as @e[tag=kitpvp.earth_pluto_parrot] at @s unless entity @e[tag=kitpvp.earth_pluto_carrier,distance=..4] run kill @s
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
# 资本家：血量比上一刻低就是挨了一下 —— 立刻掉一张纸（尸体帧抓不到，所以不用死亡判定）
execute as @e[tag=kitpvp.earth_capitalist] store result score @s kitpvp.cap_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_capitalist] at @s if score @s kitpvp.cap_hp < @s kitpvp.cap_prev run function kitpvp:skill/earth/capitalist_drop
execute as @e[tag=kitpvp.earth_capitalist] run scoreboard players operation @s kitpvp.cap_prev = @s kitpvp.cap_hp
# β转角尾巴：每刻摆到底座正后方 0.75 格一节的密集队列（吸附后不会散成稀疏的一挂）
# 底座没了就整段不跑：尾巴留在原地，不会像竖链那样悬空
# β转角竖链：把第 2..9 节每刻叠到第 1 节正上方（0.95 格一层，9 层约 7.6 格高）
# 整根柱子跟着底座走：底座有 AI 会追人，其余各节 NoAI、位置全由这里决定
# 多肽_β转角：把 5 节尾巴挂到主链最底下那颗氨基酸的正下方，并用 block_display 的锁链段把缝隙连起来
# 每段先判"那一格是不是空气"：脚下是地面就不往地里塞（会窒息），此时这一段与它的锁链都不显示
# 多肽_β转角：主链最底下那颗氨基酸下面挂着 5 节尾巴（肽键-氨基酸-肽键-氨基酸-肽键）
# 1.20.1 用 /data modify 写 Leash 不会真牵引（实测报"没有这个数据"）⇒ 绳子靠 end_rod 粒子画、尾巴每刻 tp 挂到正下方
# ★ 每段先判"那一格是不是空气"：脚下是地面时不往地里塞（塞进去会窒息），此时尾巴留在原地、绳子只剩可见的几段
# 多肽_β转角：主链最底下那颗氨基酸下面挂着 5 节尾巴（肽键-氨基酸-肽键-氨基酸-肽键）
# 1.20.1 用 /data modify 写 Leash 不会真牵引（实测报没有这个数据）⇒ 绳子靠 end_rod 粒子画、尾巴每刻 tp 挂到正下方
# ★ 每段都先判"那一格是不是空气"：脚下是地面时不往地里塞（塞进去会窒息），此时尾巴留在原地、绳子只剩可见的几段
# 多肽_β转角：主链最底下那颗氨基酸下面挂着 5 节尾巴（肽键-氨基酸-肽键-氨基酸-肽键）
# 1.20.1 用 /data modify 写 Leash 不会真牵引（实测报没有这个数据）⇒ 绳子用 end_rod 粒子画、尾巴每刻 tp 挂到正下方
# ★ 每一段都先判"那一格是不是空气"：脚下是地面时就不往地里塞（塞进去会窒息），此时尾巴留在原地、绳子只剩可见的几段
# 没有真拴绳（1.20.1 的 Leash 改 NBT 不生效），所以：每刻 tp 把尾巴拖成正下方 + 用 end_rod 粒子画 2 个点/段当绳子
# 借调员工：冷却递减 → 玩家挨打时抢锅 → 每 30 秒自己认领一件不相干的事 → 守卫跟随 → 本体没了掉解雇通知
# 泄露者：播报时钟递减；到点由 leaker_tick 从【还活着的那三个】里随机抽一个名字通报
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=1..}] run scoreboard players remove @s kitpvp.leaker_cd 1
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=..0}] at @s run function kitpvp:skill/earth/leaker_tick
# 双星：两只各带一个隐形 marker，本体没了就各自排 2 秒后的"复活还是放走"检查（先拖后判）
execute as @e[tag=kitpvp.earth_twinstar_a] at @s run tp @e[tag=kitpvp.earth_twinstar_guard_a,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_twinstar_guard_a] at @s unless entity @e[tag=kitpvp.earth_twinstar_a,distance=..3] run function kitpvp:skill/earth/twinstar_died_a
execute as @e[tag=kitpvp.earth_twinstar_b] at @s run tp @e[tag=kitpvp.earth_twinstar_guard_b,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_twinstar_guard_b] at @s unless entity @e[tag=kitpvp.earth_twinstar_b,distance=..3] run function kitpvp:skill/earth/twinstar_died_b
# COSER：判定改由 advancement kitpvp:player/coser_give 驱动（只有真被它打中的玩家会拿「物料」），这里不再扫描挨打帧
execute as @a[scores={kitpvp.coser_cd=1..}] run scoreboard players remove @s kitpvp.coser_cd 1
# COSER 猫叫：每 4 秒一声（计时在 summon 里埋初值、函数里重置）
execute as @e[tag=kitpvp.earth_coser,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/coser_meow
# ★ 不用"读尸体 Health=0 那一帧"：实测被 /damage 打死的木星在第 1 刻就整个不见了，那一帧抓不到
# ★ /kill 也照样炸（守卫只看木星在不在，不看怎么死的）；只有 game/reset 例外，它先删守卫再删木星
# ★ 已知瑕疵：两只木星靠得极近（6 格内）时会共用一枚守卫，靠得远的那只死时不劈

# 动员家：每 15 秒（300 刻）催一次"准备"，5 秒后没人点就挨瞬间伤害（结算在 mobilizer_check）
# 守卫与木星同一套：先拖到本体身上，再判"3 格内还有没有本体"，没了就播红色的"结束准备"
execute as @e[tag=kitpvp.earth_mobilizer] at @s run scoreboard players operation @e[tag=kitpvp.earth_mobilizer_guard,distance=..5,limit=1,sort=nearest] kitpvp.earth_owner = @s kitpvp.earth_owner
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
execute as @e[tag=kitpvp.earth_dominion,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/dominion_firework
# 低空飞行器（地球·73）：蝙蝠正常 AI + 重力，无重力骷髅有 AI 吊在下面，箭由原版骷髅自己射
execute as @e[tag=kitpvp.earth_lowflyer_carrier] at @s run function kitpvp:skill/earth/lowflyer_tick
# 飞龙宝宝（地球·74）：每 5 秒朝 20 格内最近的玩家吐一颗火球；火球自己不带速度，全靠 tp 直线飞
execute as @e[tag=kitpvp.earth_babywhelp] at @s run function kitpvp:skill/earth/babywhelp_tick
execute as @e[tag=kitpvp.bw_ball] at @s run function kitpvp:skill/earth/babywhelp_ball
execute as @e[tag=kitpvp.earth_captain] at @s run function kitpvp:skill/earth/captain_tick
# 铁人（地球·75）：NoAI 僵尸，靠命令驱着走；每 5 秒在脚边丢一颗 2 秒引信的小炸弹
execute as @e[tag=kitpvp.earth_ironman] at @s run function kitpvp:skill/earth/ironman_tick
# 变色者：每 5 秒换一次头顶方块（earth_cd_a 由 tick 统一递减）
execute as @e[tag=kitpvp.earth_colorchanger,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/colorchanger_shift
# 井盖：装填期（earth_cd_a，召唤后 2 秒）走完之后，头顶 2.5 格内有活人就破土（dy≈2 ⇒ 站在正上方即命中）
execute as @e[tag=kitpvp.earth_manhole,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/manhole_try
# 篝火：挨打就点燃。判据是"血量变少了"（每刻读一次 Health×100 与上一帧比）—— 比 nbt HurtTime 靠谱，任何来源的掉血都算
execute as @e[tag=kitpvp.earth_campfire] store result score @s kitpvp.fire_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=..0}] if score @s kitpvp.fire_hp < @s kitpvp.fire_prev run function kitpvp:skill/earth/campfire_ignite
execute as @e[tag=kitpvp.earth_campfire] run scoreboard players operation @s kitpvp.fire_prev = @s kitpvp.fire_hp
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=1..}] run scoreboard players remove @s kitpvp.fire_left 1
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=0}] at @s run function kitpvp:skill/earth/campfire_out
# 燃烧中每刻冒火苗（NBT 的 Fire 只是让它真的着火，这里补粒子让"在烧"一眼可见）
execute as @e[tag=kitpvp.earth_campfire,scores={kitpvp.fire_left=1..}] at @s run particle minecraft:flame ~ ~1.2 ~ 0.35 0.5 0.35 0.01 4
# 被篝火点着的玩家：burn_left 计时（玩家 NBT 改不了，只能自己算），每刻冒火星、每 20 刻 1 点火焰伤害
execute as @a[scores={kitpvp.burn_left=1..}] at @s run function kitpvp:skill/earth/burn_tick
# 音符盒：血量掉了 = 挨打了 ⇒ 打一个随机音符（6 刻冷却，连击不会糊成一片）
execute as @e[tag=kitpvp.earth_noteblock] store result score @s kitpvp.nb_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_noteblock] if score @s kitpvp.nb_hp < @s kitpvp.nb_prev run function kitpvp:skill/earth/noteblock_note
execute as @e[tag=kitpvp.earth_noteblock] run scoreboard players operation @s kitpvp.nb_prev = @s kitpvp.nb_hp
# 制图台：判定已改由 advancement kitpvp:player/carto_hit 驱动（伤害来源 = 带 earth_carto 的僵尸），只发给挨打的那一个人
# 旧写法 `@a[HurtTime:9s] + 3 格内有制图台` 不看伤害来源，站在制图台旁边摔伤、被别的怪打都会弹 pid
# 讲解石：掉一滴血就离场（不做任何减伤/免疫，一碰就没）
execute as @e[tag=kitpvp.earth_explainer] store result score @s kitpvp.nb_hp run data get entity @s Health 100
execute as @e[tag=kitpvp.earth_explainer] if score @s kitpvp.nb_hp < @s kitpvp.nb_prev run function kitpvp:skill/earth/explainer_leave
# 保洁员：每 15 秒（earth_cd_a 300）扫一次 8 格内的掉落物
execute as @e[tag=kitpvp.earth_janitor,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/janitor_sweep
# 支援者：落地那刻提到 20 格高开始下落；落地两刻后解除无敌并播尘埃
execute as @e[tag=kitpvp.sup_wait] at @s run function kitpvp:skill/earth/supporter_lift
execute as @e[tag=kitpvp.sup_falling] at @s if data entity @s {OnGround:1b} run function kitpvp:skill/earth/supporter_land
execute as @e[tag=kitpvp.earth_explainer] run scoreboard players operation @s kitpvp.nb_prev = @s kitpvp.nb_hp
execute as @e[tag=kitpvp.earth_noteblock] at @s run tp @e[tag=kitpvp.earth_noteblock_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_noteblock_guard] at @s unless entity @e[tag=kitpvp.earth_noteblock,distance=..3] run function kitpvp:skill/earth/noteblock_death
# 凤凰：每个守卫按配对号找自己的本体（多只同时在场也不会串台）；本体倒下后接管 → 留蛋 → 10 秒孵化 → 只复活一次
execute as @e[tag=kitpvp.earth_phoenix_guard] at @s run function kitpvp:skill/earth/phoenix_guard
# 音符盒死亡连音：marker 记住死亡地点，这里每刻带着 at @s 调，playsound 才不会跑到世界原点
execute as @e[tag=kitpvp.nb_dying] at @s run function kitpvp:skill/earth/noteblock_cascade
# 罐子：脚下埋一个隐形 marker 当"守卫"，每刻被拖到罐子身上；罐子没了就在守卫脚下摇一只随机生灵
# 不用"读尸体 Health=0 那一帧"：本机实测尸体不到 1 刻就被移除，读不到（木星、资本家都踩过这个坑）
execute as @e[tag=kitpvp.earth_jar] at @s run scoreboard players add @s kitpvp.earth_owner 0
execute as @e[tag=kitpvp.earth_jar] at @s run tp @e[tag=kitpvp.earth_jar_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_jar] at @s run scoreboard players operation @e[tag=kitpvp.earth_jar_guard,distance=..5,limit=1,sort=nearest] kitpvp.earth_owner = @s kitpvp.earth_owner
execute as @e[tag=kitpvp.earth_jar_guard] at @s unless entity @e[tag=kitpvp.earth_jar,distance=..3] run function kitpvp:skill/earth/jar_pop
# 蜂巢：被砍中的那一帧（HurtTime 9）给 8 格内的玩家塞"眩晕"，第 2 下翻倍、第 3 下起每次 3 个
# 酿造台：每 15 秒（300 刻）往脚边丢一瓶随机药水
execute as @e[tag=kitpvp.earth_brewer,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/brewer_drop
# 酿造台药水：落地（OnGround）或 30 刻还没落地就砸开，4 格内的玩家吃效果
scoreboard players add @e[tag=kitpvp.brw_potion] kitpvp.brw_life 1
execute as @e[tag=kitpvp.brw_potion] at @s if data entity @s {OnGround:1b} run function kitpvp:skill/earth/brewer_break
execute as @e[tag=kitpvp.brw_potion,scores={kitpvp.brw_life=30..}] at @s run function kitpvp:skill/earth/brewer_break

# 术战士 / 流浪汉的"打中人"结算：不再走 advancement（那套 NBT 条件在这个版本上一直没触发过），
# 改成抓挨打那一帧（HurtTime 9 = 伤害刚结算完的下一个 tick），再看身边 3 格内有没有对应的召唤物
# 误判：被别的僵尸蹭一下、同时 3 格内正好站着一只术战士/流浪汉也会算数（单人自测就用这个特性）
execute as @a[nbt={HurtTime:9s},gamemode=!spectator,tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.earth_spellblade,distance=..3] run function kitpvp:skill/earth/spellblade_hit
# 流浪汉吐口水的判定已改由 advancement kitpvp:player/vagrant_spit 驱动（只有真打了它的那名玩家会中），这里不再扫描
# 勺子：判定已改由 advancement kitpvp:player/spoon_hit 驱动（伤害来源 = 带 earth_spoon 的骷髅，近战和箭都算），这里不再扫描
# 旧写法 `@a[nbt={HurtTime:9s}] + 1.5 格内有勺子` 有两个毛病：① 不管伤害是谁打的，站在勺子旁边摔伤也算；② 骷髅远程射中时距离远超 1.5，箭伤永远不触发
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

# 附魔师（kit 15）：每刻走自己的强化计时
execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=15},tag=!kitpvp.spectator] at @s run function kitpvp:skill/enchanter/book_passive
execute if score #state kitpvp.game matches 1 as @a[tag=kitpvp.selected,scores={kitpvp.kit=15,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/enchanter/tick
function kitpvp:skill/enchanter/hud
