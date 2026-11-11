gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doInsomnia false
gamerule doWeatherCycle false
# 昼夜：load 默认放行（原版行为）；个别地图在开局时自己关掉，结算时 game/end 再放回来
gamerule doDaylightCycle true
gamerule naturalRegeneration true
gamerule fallDamage true
gamerule announceAdvancements false
gamerule doImmediateRespawn true
gamerule logAdminCommands false
gamerule commandBlockOutput false
gamerule sendCommandFeedback false

scoreboard objectives add kitpvp.kit dummy "职业"
scoreboard objectives add kitpvp.cd dummy "技能冷却"
scoreboard objectives add kitpvp.cd2 dummy "第二技能冷却"
scoreboard objectives add kitpvp.alive dummy "存活"
scoreboard objectives add kitpvp.lives dummy "命数"
scoreboard objectives add kitpvp.kills dummy "击杀数"
scoreboard objectives add kitpvp.deaths dummy "死亡数"
scoreboard objectives add kitpvp.map dummy "地图"
scoreboard objectives add kitpvp.timer dummy "倒计时"
scoreboard objectives add kitpvp.inv dummy
scoreboard objectives add kitpvp.death_detect deathCount
scoreboard objectives add kitpvp.death_seen dummy
scoreboard objectives add kitpvp.game dummy "游戏状态"
scoreboard objectives add kitpvp.item dummy "物品计数"
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.tank_last dummy "坦克技能快照"
scoreboard objectives add kitpvp.assassin_used minecraft.used:minecraft.enderman_spawn_egg
scoreboard objectives add kitpvp.assassin_last dummy "刺客技能快照"
scoreboard objectives add kitpvp.fisher_used minecraft.used:minecraft.drowned_spawn_egg
scoreboard objectives add kitpvp.fisher_last dummy "渔夫技能快照"
scoreboard objectives add kitpvp.fisher_no_tri dummy "渔夫无戟计时器"
scoreboard objectives add kitpvp.ready_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add kitpvp.ready_last dummy "大厅准备快照"
scoreboard objectives add kitpvp.tmp dummy
scoreboard objectives add kitpvp.soul_rand dummy "魂石随机数"
scoreboard objectives add kitpvp.soul_next dummy "下次魂石倒计时"
scoreboard objectives add kitpvp.soul_bow_timer dummy "魂石弓倒计时"
scoreboard objectives add kitpvp.soul_warrior_used minecraft.used:minecraft.blaze_spawn_egg
scoreboard objectives add kitpvp.soul_archer_used minecraft.used:minecraft.skeleton_spawn_egg
scoreboard objectives add kitpvp.soul_warrior_last dummy "战士魂石快照"
scoreboard objectives add kitpvp.soul_archer_last dummy "弓箭手魂石快照"
scoreboard objectives add kitpvp.arsonist_used minecraft.used:minecraft.splash_potion
scoreboard objectives add kitpvp.arsonist_last dummy
scoreboard objectives add kitpvp.arsonist_ammo dummy
scoreboard objectives add kitpvp.fire_timer dummy
scoreboard objectives add kitpvp.soul_ghost_used minecraft.used:minecraft.vex_spawn_egg
scoreboard objectives add kitpvp.soul_ghost_last dummy "幽灵魂石快照"
scoreboard objectives add kitpvp.soul_ghost_timer dummy "幽灵魂石倒计时"
scoreboard objectives add kitpvp.soul_pirate_used minecraft.used:minecraft.pillager_spawn_egg
scoreboard objectives add kitpvp.soul_pirate_last dummy "海盗魂石快照"
scoreboard objectives add kitpvp.soul_pirate_timer dummy "魂石手炮倒计时"
scoreboard objectives add kitpvp.soul_fisher_used minecraft.used:minecraft.cod_spawn_egg
scoreboard objectives add kitpvp.soul_fisher_last dummy "渔夫魂石快照"
scoreboard objectives add kitpvp.soul_fisher_timer dummy "渔夫魂石倒计时"
scoreboard objectives add kitpvp.soul_zombie_used minecraft.used:minecraft.husk_spawn_egg
scoreboard objectives add kitpvp.soul_zombie_last dummy "僵尸魂石快照"
scoreboard objectives add kitpvp.soul_zombie_timer dummy "僵尸魂石倒计时"
scoreboard objectives add kitpvp.soul_earth_used minecraft.used:minecraft.villager_spawn_egg
scoreboard objectives add kitpvp.soul_earth_last dummy "地球魂石快照"
scoreboard objectives add kitpvp.soul_earth_team dummy "地球魂石认出的队编号（挂 marker：1..6 幽灵 / 7..12 炮台 / 13..18 里驯兽师 / 19..24 地球）"
scoreboard objectives add kitpvp.soul_li_used minecraft.used:minecraft.pig_spawn_egg
scoreboard objectives add kitpvp.soul_li_last dummy "李朱俊泽魂石快照"
scoreboard objectives add kitpvp.soul_tamer_used minecraft.used:minecraft.cat_spawn_egg
scoreboard objectives add kitpvp.soul_tamer_last dummy "驯兽师魂石快照"
scoreboard objectives add kitpvp.soul_sun_used minecraft.used:minecraft.allay_spawn_egg
scoreboard objectives add kitpvp.soul_sun_last dummy "太阳魂石快照"
scoreboard objectives add kitpvp.soul_mercury_used minecraft.used:minecraft.dolphin_spawn_egg
scoreboard objectives add kitpvp.soul_mercury_last dummy "水星魂石快照"
scoreboard objectives add kitpvp.soul_venus_used minecraft.used:minecraft.ocelot_spawn_egg
scoreboard objectives add kitpvp.soul_venus_last dummy "金星魂石快照"
scoreboard objectives add kitpvp.soul_slime_used minecraft.used:minecraft.slime_spawn_egg
scoreboard objectives add kitpvp.soul_slime_last dummy "史莱姆魂石快照"
scoreboard objectives add kitpvp.soul_slime_timer dummy "史莱姆魂石倒计时"
# 传送枪：里·末影人（kit/tainted_enderman）与魂石（skill/soul/use_ep）发的都是 minecraft:spyglass{KitPortalGun:1b}
# 旧版这里统计的是 warped_fungus_on_a_stick，跟实际发的物品对不上 ⇒ tep_used 永远是 0、右键不开门。先把旧目标删掉再按 spyglass 建
scoreboard objectives remove kitpvp.tep_used
scoreboard objectives add kitpvp.tep_used minecraft.used:minecraft.spyglass
scoreboard objectives add kitpvp.tep_last dummy "传送枪使用快照"
scoreboard objectives add kitpvp.tep_cd dummy "传送枪装填（40 = 2 秒）"
scoreboard objectives add kitpvp.tep_life dummy "传送门寿命（400 = 20 秒）"
scoreboard objectives add kitpvp.tep_ready dummy "穿门后的免疫刻数"
scoreboard objectives add kitpvp.tep_pid dummy "传送门的配对号（每个玩家一个）"
scoreboard objectives add kitpvp.tep_owner dummy "门的主人配对号（挂 marker）"
scoreboard objectives add kitpvp.soul_ep_used minecraft.used:minecraft.endermite_spawn_egg
scoreboard objectives add kitpvp.soul_ep_last dummy "末影人魂石快照"
scoreboard objectives add kitpvp.soul_ep_timer dummy "末影人魂石传送枪剩余刻数（400 = 20 秒）"
scoreboard objectives add kitpvp.tep_cd_s dummy "魂石传送枪装填（4 = 0.2 秒）"
scoreboard objectives add kitpvp.tep_face dummy "门的朝向类型：0 墙 / 1 地面（往天上出）/ 2 天花板（往地下出）"
scoreboard objectives add kitpvp.rocket_charge dummy "蓄力火箭跳的蓄力刻数（0..60）"
scoreboard objectives add kitpvp.soul_timer dummy "魂石倒计时（marker / 实体：400 = 20 秒）"
# 大厅起跳按钮的 advancement：加载失败过一次（blocks 写成了标签），万一有谁被旧版本授过奖就永远不再触发 —— 每次 reload 清一遍
advancement revoke @a only kitpvp:player/lobby_launch
advancement revoke @a only kitpvp:player/vagrant_spit
advancement revoke @a only kitpvp:player/coser_give
advancement revoke @a only kitpvp:player/spoon_hit
advancement revoke @a only kitpvp:player/carto_hit

# 新魂石的 last 快照：/reload 时把在线玩家的快照对齐到当前 used，否则 `if score used > last` 因为 last 不存在而永远不成立
scoreboard players operation @a kitpvp.soul_tamer_last = @a kitpvp.soul_tamer_used
scoreboard players operation @a kitpvp.soul_sun_last = @a kitpvp.soul_sun_used
scoreboard players operation @a kitpvp.soul_mercury_last = @a kitpvp.soul_mercury_used
scoreboard players operation @a kitpvp.soul_venus_last = @a kitpvp.soul_venus_used
scoreboard players operation @a kitpvp.soul_slime_last = @a kitpvp.soul_slime_used
scoreboard objectives add kitpvp.ghost_minion_cd dummy "阴兵召唤冷却"
scoreboard objectives add kitpvp.tid dummy "队槽编号"
scoreboard objectives add kitpvp.rng dummy
scoreboard objectives add kitpvp.ender_used minecraft.used:minecraft.ender_pearl
scoreboard objectives add kitpvp.ender_last dummy
scoreboard objectives add kitpvp.ender_ammo dummy
# 旧名 kitpvp.taint_* 已随里职业统一改名（→ kitpvp.tainted_*）：老世界里残留的是空目标，在这里清掉
scoreboard objectives remove kitpvp.taint_turret_used
scoreboard objectives remove kitpvp.taint_turret_last
scoreboard objectives remove kitpvp.taint_core_used
scoreboard objectives remove kitpvp.taint_core_last
scoreboard objectives add kitpvp.tainted_turret_used minecraft.used:minecraft.stray_spawn_egg
scoreboard objectives add kitpvp.tainted_turret_last dummy "炮台令牌快照"
scoreboard objectives add kitpvp.werewolf_used minecraft.used:minecraft.wolf_spawn_egg
scoreboard objectives add kitpvp.werewolf_last dummy "狼人令牌快照"
scoreboard objectives add kitpvp.werewolf_hit_cd dummy "狼人命中冷却"
# 与 werewolf_used 同 criterion：两个职业共用 wolf_spawn_egg，各自按 kit 分闸门（见 04 §五）
scoreboard objectives add kitpvp.tamer_used minecraft.used:minecraft.wolf_spawn_egg
scoreboard objectives add kitpvp.tamer_last dummy "驯兽师狼蛋快照"
# ⚠ 改过 criterion 的统计目标：objectives add 对**已存在**的目标不会更新 criterion，
#   老世界里它会继续记旧物品 ⇒ 新令牌用了也不涨计数、技能静默不触发。
#   统计目标是只读的（值由统计实时给出），所以 remove 再 add 不会丢数据，只是重建注册。
scoreboard objectives remove kitpvp.tainted_core_used
scoreboard objectives add kitpvp.tainted_core_used minecraft.used:minecraft.blaze_spawn_egg
scoreboard objectives add kitpvp.tainted_core_last dummy "熔火核心快照"
scoreboard objectives add kitpvp.ttid dummy "炮台队槽编号"
# 出生点编号：map/*/spawn_N 每局写入，重生兜底按它找回自己的锚点（见 04 §十一）
scoreboard objectives add kitpvp.spawn_slot dummy "出生点编号"
scoreboard objectives add kitpvp.turret_owner dummy
scoreboard objectives add kitpvp.turret_seq dummy
scoreboard objectives add kitpvp.turret_molten_timer dummy
scoreboard objectives add kitpvp.turret_heal_cd dummy "炮台回血冷却"

# 里·渔夫：两个技能各一个令牌（发光鱿鱼蛋 / 鱿鱼蛋），共用一把锁（cd 与 cd2 就是两个技能自身的冷却）
scoreboard objectives add kitpvp.tainted_fisher_blue_used minecraft.used:minecraft.glow_squid_spawn_egg
scoreboard objectives add kitpvp.tainted_fisher_blue_last dummy "里·渔夫苍快照"
scoreboard objectives add kitpvp.tainted_fisher_domain_used minecraft.used:minecraft.squid_spawn_egg
scoreboard objectives add kitpvp.tainted_fisher_domain_last dummy "里·渔夫领域快照"
scoreboard objectives add kitpvp.tainted_fisher_cang_timer dummy "里·渔夫苍前摇计时"
scoreboard objectives add kitpvp.tainted_fisher_domain_timer dummy "里·渔夫领域计时"

# 太阳（kit 65）：两个技能各一个令牌（蜜蜂蛋 / 蝙蝠蛋），各走各的冷却；换弹另有 kitpvp.sun_reload
scoreboard objectives add kitpvp.sun_flare_used minecraft.used:minecraft.bee_spawn_egg
scoreboard objectives add kitpvp.sun_flare_last dummy "太阳耀斑快照"
scoreboard objectives add kitpvp.sun_spot_used minecraft.used:minecraft.bat_spawn_egg
scoreboard objectives add kitpvp.sun_spot_last dummy "太阳黑子快照"
scoreboard objectives add kitpvp.sun_flare_timer dummy "太阳耀斑干扰计时"
scoreboard objectives add kitpvp.sun_reload dummy "太阳换弹冷却"

# 药剂师（kit 12）：技能组 1 与纵火狂共用 splash_potion 统计，只能当粗筛；技能组 2 用 potion 统计
scoreboard objectives add kitpvp.alchemist_used minecraft.used:minecraft.splash_potion
scoreboard objectives add kitpvp.alchemist_last dummy "药剂师投掷快照"
scoreboard objectives add kitpvp.alchemist_drink_used minecraft.used:minecraft.potion
scoreboard objectives add kitpvp.alchemist_drink_last dummy "药剂师秘药快照"
scoreboard objectives add kitpvp.pa_type dummy "药剂师手持药剂类型"
scoreboard objectives add kitpvp.pa_type_prev dummy "药剂师上一刻药剂类型"
scoreboard objectives add kitpvp.pa_drink_type dummy "药剂师手持秘药类型"
scoreboard objectives add kitpvp.pa_drink_type_prev dummy "药剂师上一刻秘药类型"

# 里·驯兽师（kit 30）：七枚召唤蛋各一对 used/last（骷髅 / 恼鬼 / 烈焰人蛋与魂石共用同一统计）
scoreboard objectives add kitpvp.ttamer_zombie_used minecraft.used:minecraft.zombie_spawn_egg
scoreboard objectives add kitpvp.ttamer_zombie_last dummy "里·驯兽师亡灵快照"
scoreboard objectives add kitpvp.ttamer_skeleton_used minecraft.used:minecraft.skeleton_spawn_egg
scoreboard objectives add kitpvp.ttamer_skeleton_last dummy "里·驯兽师骸骨快照"
scoreboard objectives add kitpvp.ttamer_creeper_used minecraft.used:minecraft.creeper_spawn_egg
scoreboard objectives add kitpvp.ttamer_creeper_last dummy "里·驯兽师爆破快照"
scoreboard objectives add kitpvp.ttamer_vindicator_used minecraft.used:minecraft.vindicator_spawn_egg
scoreboard objectives add kitpvp.ttamer_vindicator_last dummy "里·驯兽师卫道快照"
scoreboard objectives add kitpvp.ttamer_witch_used minecraft.used:minecraft.witch_spawn_egg
scoreboard objectives add kitpvp.ttamer_witch_last dummy "里·驯兽师巫祝快照"
scoreboard objectives add kitpvp.ttamer_vex_used minecraft.used:minecraft.vex_spawn_egg
scoreboard objectives add kitpvp.ttamer_vex_last dummy "里·驯兽师怨灵快照"
scoreboard objectives add kitpvp.ttamer_blaze_used minecraft.used:minecraft.blaze_spawn_egg
scoreboard objectives add kitpvp.ttamer_blaze_last dummy "里·驯兽师灼炎快照"
scoreboard objectives add kitpvp.ttamer_tid dummy "召唤物队槽编号"

# 炸弹兵（kit 19）/ 里·炸弹兵（kit 32）：五套令牌共用蘑菇牛蛋，靠载体的 tag 分流（dispatch）
scoreboard objectives add kitpvp.bomb_used minecraft.used:minecraft.mooshroom_spawn_egg
scoreboard objectives add kitpvp.bomb_last dummy "炸弹兵令牌快照"
scoreboard objectives add kitpvp.bomb_small_cd dummy "小炸弹补货计时"
scoreboard objectives add kitpvp.bomb_big_cd dummy "大炸弹补货计时"
scoreboard objectives add kitpvp.bomb_fake_cd dummy "假核弹补货计时"
scoreboard objectives add kitpvp.bomb_track_cd dummy "跟踪炸弹补货计时"
scoreboard objectives add kitpvp.bomb_nuke_cd dummy "核弹补货计时"
scoreboard objectives add kitpvp.bomb_life dummy "跟踪炸弹骑手寿命"
scoreboard objectives add kitpvp.btid dummy "炸弹兵跟踪炸弹队槽编号"

# 金星（kit 67）：三枚模块令牌 + 舔狗（归属 / 两个模块计时）+ 全局冷度
scoreboard objectives add kitpvp.venus_chill_used minecraft.used:minecraft.polar_bear_spawn_egg
scoreboard objectives add kitpvp.venus_chill_last dummy "金星制冷快照"
scoreboard objectives add kitpvp.venus_arm_used minecraft.used:minecraft.evoker_spawn_egg
scoreboard objectives add kitpvp.venus_arm_last dummy "金星武装快照"
scoreboard objectives add kitpvp.venus_bomb_used minecraft.used:minecraft.silverfish_spawn_egg
scoreboard objectives add kitpvp.venus_bomb_last dummy "金星自爆快照"
scoreboard objectives add kitpvp.venus_cd3 dummy "第三技能冷却"
scoreboard objectives add kitpvp.venus_dog_timer dummy "舔狗复活倒计时"
# 冥王星（kit 76）：鹦鹉分身（归属编号 + 鹦鹉身上的归属）
scoreboard objectives add kitpvp.ptid dummy "冥王星鹦鹉归属编号"
scoreboard objectives add kitpvp.parrot_owner dummy "冥王星鹦鹉归属（挂鹦鹉）"
scoreboard objectives add kitpvp.parrot_miss dummy "冥王星鹦鹉缺失计时（缺 6 刻才判死，防跨区传送误杀）"
scoreboard objectives add kitpvp.venus_chill_timer dummy "制冷模块计时"
scoreboard objectives add kitpvp.venus_arm_timer dummy "武装模块计时"
scoreboard objectives add kitpvp.dog_owner dummy "舔狗归属"
scoreboard objectives add kitpvp.vtid dummy "舔狗队槽编号"
scoreboard objectives add kitpvp.coldness dummy "冷度"

# 文明小子（kit 87）：口水是喷溅药水（与纵火狂 / 药剂师共用统计），恶魔形态用独立令牌
scoreboard objectives add kitpvp.civil_used minecraft.used:minecraft.splash_potion
scoreboard objectives add kitpvp.civil_last dummy "文明小子口水快照"
scoreboard objectives add kitpvp.civil_demon_used minecraft.used:minecraft.strider_spawn_egg
scoreboard objectives add kitpvp.civil_demon_last dummy "文明小子恶魔快照"
scoreboard objectives add kitpvp.civil_demon_timer dummy "恶魔形态计时"

# 李朱俊泽（kit 88）：召唤蛋（猪蛋本服唯一来源）+ 内联循环计时器
scoreboard objectives add kitpvp.li_pig_used minecraft.used:minecraft.pig_spawn_egg
scoreboard objectives add kitpvp.li_pig_last dummy "李朱俊泽召唤快照"

# 地球（kit 68）：召唤生灵（山羊蛋当载体），召唤物计时器都挂在实体上
scoreboard objectives add kitpvp.earth_used minecraft.used:minecraft.goat_spawn_egg
scoreboard players set #oracle_five kitpvp.game 5
scoreboard objectives add kitpvp.earth_fw_life dummy "内卫烟花烟团还能冒几轮"
scoreboard objectives add kitpvp.dominion_age dummy "内卫存活刻数（过 240 = 12 秒就只放烟花、不再留烟）"
scoreboard objectives add kitpvp.earth_last dummy "地球召唤快照"
scoreboard objectives add kitpvp.earth_cd_a dummy "地球召唤物技能计时"
scoreboard objectives add kitpvp.minecart_life dummy "矿车寿命（800 = 40 秒，到 0 连船一起自毁）"
scoreboard objectives add kitpvp.skater_snd dummy "滑冰者滑行音效冷却"
scoreboard objectives add kitpvp.earth_lev dummy "地球超凡升天计时"
scoreboard objectives add kitpvp.earth_life dummy "地球召唤物寿命"
scoreboard objectives add kitpvp.earth_grass_arm dummy "可疑草丛落地的迟钝计时"
scoreboard objectives add kitpvp.earth_owner dummy "地球召唤物的归属编号（= 主人的 etid）"
scoreboard objectives add kitpvp.earth_hp dummy "Ollama 上一次的血量（Health x10）"
scoreboard objectives add kitpvp.earth_hp_new dummy "Ollama 这一刻的血量（Health x10，比完就回写）"
scoreboard objectives add kitpvp.earth_snow dummy "术战士细雪还剩多少刻"
scoreboard objectives add kitpvp.bee_slow_snd dummy "被大蜜蜂减速的提示音冷却（刻）"
scoreboard objectives add kitpvp.sparky_charge dummy "电磁炮充能（0..200，满 200 放电 = 10 秒）"
scoreboard objectives add kitpvp.sparky_beep dummy "电磁炮充能滴声计时（20 刻一响）"
# 迫击炮（69 号）：这些以前漏建过，缺了就会被静默忽略（鱼不动、堆在炮口）
scoreboard objectives add kitpvp.mo_owner dummy "鱼弹的归属编号（= 迫击炮主人的 etid，0 = 无主）"
scoreboard objectives add kitpvp.mo_vy dummy "鱼弹竖直初速（每刻 -1）"
scoreboard objectives add kitpvp.mo_hs dummy "鱼弹水平速度 x100（按开炮距离分档）"
scoreboard objectives add kitpvp.mo_life dummy "鱼弹已经飞了多少刻"
scoreboard objectives add kitpvp.sup_land dummy "支援者落地后过了几刻（2 刻才收无敌）"
scoreboard objectives add kitpvp.brw_life dummy "酿造台药水落地后过了几刻（30 刻还没落地就强制砸开）"
scoreboard objectives add kitpvp.leaker_cd dummy "泄露者的通报时钟（15 秒 = 300 刻）"
scoreboard objectives add kitpvp.skater_call dummy "滑冰者寒带动静计时（2 次滑行一声）"
scoreboard players set #skater_four kitpvp.game 4
scoreboard objectives add kitpvp.gb_mode dummy "变速器当前模式（0 空旷 / 1 有人）"
scoreboard objectives add kitpvp.gb_summoner dummy "这一只变速器是谁召的（1 = 召唤者本人，不计入有人靠近）"
scoreboard objectives add kitpvp.coser_cd dummy "COSER 发物料的冷却（60 刻 = 3 秒）"
scoreboard objectives add kitpvp.earth_hit_hits dummy "地球生灵打中人的累计次数（排查触发用）"
scoreboard objectives add kitpvp.mob_ready dummy "动员家那一轮的准备状态（0 没点 / 1 点了 / 2 已结算）"
scoreboard objectives add kitpvp.px dummy "交警（闪现版）：玩家 x 坐标 x100（这一刻）"
scoreboard objectives add kitpvp.pz dummy "交警（闪现版）：玩家 z 坐标 x100（这一刻）"
scoreboard objectives add kitpvp.px_old dummy "交警（闪现版）：玩家 x 坐标 x100（上一刻）"
scoreboard objectives add kitpvp.pz_old dummy "交警（闪现版）：玩家 z 坐标 x100（上一刻）"
scoreboard objectives add kitpvp.pdx dummy "交警（闪现版）：x 位移绝对值（格/刻 x100）"
scoreboard objectives add kitpvp.pdz dummy "交警（闪现版）：z 位移绝对值（格/刻 x100）"
scoreboard objectives add kitpvp.pdx2 dummy "交警（闪现版）：x 位移平方"
scoreboard objectives add kitpvp.pdz2 dummy "交警（闪现版）：z 位移平方"
scoreboard objectives add kitpvp.pspd dummy "交警（闪现版）：玩家速度分 = dx²+dz²（平方距离，免开方）"
scoreboard objectives add kitpvp.etid dummy "地球召唤物队槽编号"
# 取绝对值要用 -1 当乘数（scoreboard 没有 abs）
scoreboard players set #neg kitpvp.game -1
# 变色者换头用：3 位随机（0..7）对 6 取模 ⇒ 六种方块等概率
scoreboard objectives add kitpvp.fire_left dummy "篝火剩余燃烧刻数（-1 = 待点火，0 = 刚烧完，1..100 = 燃烧中）"
scoreboard objectives add kitpvp.nb_hp dummy "音符盒当前血量 ×100（每刻读一次）"
scoreboard objectives add kitpvp.nb_prev dummy "音符盒上一帧血量（掉了就说明挨打了）"
scoreboard objectives add kitpvp.nb_step dummy "死亡音符盒连音：弹音器走到第几刻"

scoreboard objectives add kitpvp.jan_unit dummy "保洁员清扫：单个掉落物的件数（按件计，不按堆）"
scoreboard objectives add kitpvp.cap_hp dummy "资本家当前血量（×100，用来判断挨打）"
scoreboard objectives add kitpvp.cap_prev dummy "资本家上一次的血量（×100）"

scoreboard objectives add kitpvp.fire_hp dummy "篝火热血量 ×100（每刻读一次，用来判断这一帧有没有掉血）"
scoreboard objectives add kitpvp.fire_prev dummy "篝火上一帧的血量（拿它和 fire_hp 比，掉血了就说明挨打了）"
scoreboard objectives add kitpvp.flyer_dive dummy "飞行器俯冲剩余刻数（50 = 正在扑）"
scoreboard objectives add kitpvp.at_charge dummy "反装甲步兵装填（60 开炮；-60..-1 是开炮后跑位）"
scoreboard objectives add kitpvp.at_life dummy "反装甲炮弹飞了几刻"
scoreboard objectives add kitpvp.at_owner dummy "炮弹的主人队槽"
scoreboard objectives add kitpvp.at_shot dummy "反装甲步兵打没打过那一炮（1 = 打完了，永久速度 I）"
scoreboard objectives add kitpvp.fl_summoner dummy "这一只飞行器是谁召的（1 = 召唤者本人，俯冲时避开）"
scoreboard objectives add kitpvp.pluto_pair dummy "冥王星（召唤物）：僵尸和头顶鹦鹉的配对号"
scoreboard objectives add kitpvp.pluto_miss dummy "冥王星（召唤物）：鹦鹉缺失计时（缺 6 刻才判死，防跨区块误杀）"
scoreboard objectives add kitpvp.hive_hits dummy "蜂巢挨了几下（1→1个眩晕，2→2个，3下起每次3个）"
scoreboard players set #six kitpvp.game 6
scoreboard objectives add kitpvp.sat_phase dummy "土星轨道蠹虫的相位（0..7，每 4 刻 +1）"
scoreboard players set #sat_mod kitpvp.game 8
scoreboard objectives add kitpvp.dser_hp dummy "逃兵当前血量（每刻 data get 读一次，用来判半血）"

# 预留（暂无消费者，刻意保留）：item = 物品计数
scoreboard objectives modify kitpvp.kit displayname {"text":"职业","color":"gold"}
scoreboard objectives modify kitpvp.lives displayname {"text":"命数","color":"red"}
scoreboard objectives modify kitpvp.kills displayname {"text":"击杀","color":"aqua"}

scoreboard objectives setdisplay sidebar kitpvp.lives

# 幽灵阴兵队：每位使用者一队，最多 6 队循环复用（队槽由 summon/ghost_minion_pair 惰性分配）
team add ghost_1
team add ghost_2
team add ghost_3
team add ghost_4
team add ghost_5
team add ghost_6

# 炮台队：与阴兵那套分开，避免队槽复用把两套召唤物串成一队（见 04）
team add turret_1
team add turret_2
team add turret_3
team add turret_4
team add turret_5
team add turret_6

# 里·驯兽师的召唤物队：与阴兵 / 炮台两套分开，避免队槽复用把不同来源的召唤物串成一队
team add ttamer_1
team add ttamer_2
team add ttamer_3
team add ttamer_4
team add ttamer_5
team add ttamer_6

# 地球的召唤物队：与阴兵 / 炮台 / 驯兽师三套分开
team add earth_1
team add earth_2
team add earth_3
team add earth_4
team add earth_5
team add earth_6
team add bomb_1
team add bomb_2
team add bomb_3
team add bomb_4
team add bomb_5
team add bomb_6

tag @a remove kitpvp.selected
tag @a remove kitpvp.invincible
tag @a remove kitpvp.sudden_death
tag @a remove kitpvp.in_lobby
tag @a remove kitpvp.spectator
tag @a remove kitpvp.death_immune
tag @a remove kitpvp.keep_inventory
tag @a remove kitpvp.respawn_pending
tag @a remove kitpvp.joined
tag @a remove kitpvp.shield_held
tag @a remove kitpvp.assassin_hidden
tag @a remove kitpvp.pirate_reload_cd
tag @a remove kitpvp.soul_bow_held
tag @a remove kitpvp.soul_transit
tag @a remove kitpvp.soul_ghost_active
tag @a remove kitpvp.soul_pirate_held
tag @a remove kitpvp.arrow_user
tag @a remove kitpvp.on_pad
tag @a remove kitpvp.alchemist_elixir_used
tag @a remove kitpvp.hold_pa
tag @a remove kitpvp.hold_pa_prev
tag @a remove kitpvp.hold_pa_drink
tag @a remove kitpvp.hold_pa_drink_prev

scoreboard players set @a kitpvp.kit 0
scoreboard players set @a kitpvp.cd 0
scoreboard players set @a kitpvp.cd2 0
scoreboard players set @a kitpvp.alive 1
scoreboard players set @a kitpvp.lives 3
scoreboard players set @a kitpvp.kills 0
scoreboard players set @a kitpvp.deaths 0
scoreboard players set @a kitpvp.inv 0
scoreboard players set @a kitpvp.death_detect 0
scoreboard players set @a kitpvp.death_seen 0
scoreboard players set @a kitpvp.item 0
scoreboard players set @a kitpvp.tid 0
scoreboard players set @a kitpvp.ttid 0
scoreboard players set @a kitpvp.fisher_no_tri 0
scoreboard players set @a kitpvp.turret_heal_cd 0
scoreboard players set @a kitpvp.werewolf_hit_cd 0
scoreboard players set @a kitpvp.sun_reload 0
scoreboard players set @a kitpvp.pa_type 0
scoreboard players set @a kitpvp.pa_type_prev 0
scoreboard players set @a kitpvp.pa_drink_type 0
scoreboard players set @a kitpvp.pa_drink_type_prev 0
scoreboard players set @a kitpvp.ttamer_tid 0
# etid 不在这里清零：它必须和玩家所在的 earth_* 队保持一致，重载时清分不清队会重新撞槽
scoreboard players add @a kitpvp.etid 0
scoreboard players set @a kitpvp.coldness 0
scoreboard players set @a kitpvp.venus_cd3 0
scoreboard players set @a kitpvp.venus_dog_timer 0
scoreboard players set @a kitpvp.civil_demon_timer 0
# vtid 用补零而不是置零：重载后保留已分配的编号，重载前召出的舔狗才认得出主人
# （编号在 kit/venus 里每次选职重新领取，所以重载不会造成两人同号，见 04 §十四）
scoreboard players add @a kitpvp.vtid 0
scoreboard players set @a kitpvp.soul_next 0
scoreboard players set @a kitpvp.soul_zombie_timer 0
scoreboard players set @a kitpvp.soul_slime_timer 0
scoreboard players set @a kitpvp.rocket_charge 0
scoreboard players set @a kitpvp.tep_cd 0
scoreboard players set @a kitpvp.tep_ready 0
scoreboard players operation @a kitpvp.tep_last = @a kitpvp.tep_used
scoreboard players add #tep_pid kitpvp.game 0
scoreboard players set @a kitpvp.tep_cd_s 0
scoreboard players set @a kitpvp.soul_ep_timer 0
execute as @a run scoreboard players operation @s kitpvp.soul_ep_last = @s kitpvp.soul_ep_used
# 传送门状态灯：两条 bossbar，橙/蓝各一条；没有门时是灰色空心方块 + 0 格进度
# 注意：1.20.1 的 bossbar 没有 `overlay` 这个属性（notched 样式属于 `style`），写了会让整份 load.mcfunction 不加载
bossbar add kitpvp:tep_hud_orange {"text":"□ 橙门","color":"dark_gray"}
bossbar add kitpvp:tep_hud_blue {"text":"□ 蓝门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_orange color white
bossbar set kitpvp:tep_hud_blue color white
bossbar set kitpvp:tep_hud_orange style progress
bossbar set kitpvp:tep_hud_blue style progress
bossbar set kitpvp:tep_hud_orange value 0
bossbar set kitpvp:tep_hud_blue value 0
bossbar add kitpvp:tep_hud_red {"text":"□ 红门","color":"dark_gray"}
bossbar add kitpvp:tep_hud_purple {"text":"□ 紫门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_red color white
bossbar set kitpvp:tep_hud_purple color white
bossbar set kitpvp:tep_hud_red style progress
bossbar set kitpvp:tep_hud_purple style progress
bossbar set kitpvp:tep_hud_red value 0
bossbar set kitpvp:tep_hud_purple value 0
# 传送门是临时实体：重载时清掉上一局残留在已加载区块里的
kill @e[tag=kitpvp.tep_a]
kill @e[tag=kitpvp.tep_b]
scoreboard players set @a kitpvp.parrot_miss 0
scoreboard players set @a kitpvp.bomb_small_cd 0
scoreboard players set @a kitpvp.bomb_big_cd 0
scoreboard players set @a kitpvp.bomb_fake_cd 0
scoreboard players set @a kitpvp.bomb_track_cd 0
scoreboard players set @a kitpvp.bomb_nuke_cd 0
# btid 用补零保留：重载后队还在，编号必须和玩家所在队一致（同 etid / vtid）
scoreboard players add @a kitpvp.btid 0
execute as @a run scoreboard players operation @s kitpvp.bomb_last = @s kitpvp.bomb_used
# 换过 criterion 的快照要重新对齐，否则 old 的快照值会一直压着新计数不触发
execute as @a run scoreboard players operation @s kitpvp.tainted_core_last = @s kitpvp.tainted_core_used

scoreboard players set #global kitpvp.map 0
scoreboard players set #global kitpvp.timer 0
scoreboard players set #state kitpvp.game 0
scoreboard players set #survivors kitpvp.game 0
scoreboard players set #debug kitpvp.game 0
scoreboard players set #soul_count kitpvp.game 16
scoreboard players set #ghost_tid kitpvp.game 0
scoreboard players set #ghost_need_new kitpvp.game 0
scoreboard players set #lobby kitpvp.game 0
scoreboard players set #unready kitpvp.game 0
scoreboard players set #ttamer kitpvp.game 0
scoreboard players set #btid kitpvp.game 0
scoreboard players add #vtid kitpvp.game 0
scoreboard players add #ptid kitpvp.game 0
scoreboard players set #pparrot kitpvp.game 0
scoreboard players set #vdog kitpvp.game 0
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #li_active kitpvp.game 0
scoreboard players set #licount kitpvp.game 0
scoreboard players set #liapoc kitpvp.game 0
scoreboard players set #lipurge kitpvp.game 0
scoreboard players set #hacker_count kitpvp.game 0
scoreboard players set #hacker_prev kitpvp.game 0
scoreboard players set #li_soul kitpvp.game -1
# #li_soul 自 2026-11-10 起不再使用（魂石改成常驻种子、没有时限），保留这一行只为兼容旧存档里的残留数值
scoreboard players set #eslot kitpvp.game 0
scoreboard players set #wolfsweep kitpvp.game 0

data remove storage kitpvp:main temp
data remove storage kitpvp:main player

# 装饰实体设为无敌，避免被清场命令波及
tag @e[type=minecraft:armor_stand] add kitpvp.displayitem
tag @e[type=minecraft:item_frame] add kitpvp.displayitem
tag @e[type=minecraft:glow_item_frame] add kitpvp.displayitem
tag @e[type=minecraft:painting] add kitpvp.displayitem
tag @e[type=minecraft:chest_minecart] add kitpvp.displayitem
tag @e[name="海龟蛋"] add kitpvp.displayitem

execute as @e[tag=kitpvp.displayitem] run data merge entity @s {Invulnerable:1b}

say Kitpvp loaded · build 2026-11-06 深夜 3（内卫烟 ×3 / 深池 / 电磁炮 / 双星）
scoreboard objectives add kitpvp.dl_summoner dummy "这一只深池飞行兵是谁召的（1 = 召唤者本人，不索敌）"
scoreboard objectives add kitpvp.mh_summoner dummy "这一只井盖是谁埋的（1 = 召唤者本人，不触发）"
scoreboard objectives add kitpvp.cop_summoner dummy "这一只交警是谁召的（1 = 召唤者本人，闪现不截他）"
scoreboard objectives add kitpvp.lf_summoner dummy "这一只低空飞行器是谁召的（1 = 召唤者本人，弓箭手不射他）"
