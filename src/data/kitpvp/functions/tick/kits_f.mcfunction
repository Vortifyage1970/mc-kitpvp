# 太阳（kit 65）：被动"免疫一切状态效果"每刻清空效果；两个技能各自独立冷却（耀斑看 cd，黑子看 cd2）
execute as @a[scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/passive
# ⚠ 必须带 at @s：耀斑 / 黑子的距离判定与粒子都靠它锚定（tick 本身执行在世界出生点）
# ⚠ 必须带 kit=65：否则别人捡到地上的令牌右键也会真的放出技能（其它职业都有这道闸门）
# 干扰刷新与 5 秒读秒（挂在中招者身上，中招后死亡也照走完）
execute as @a[tag=kitpvp.sun_flare] at @s run function kitpvp:skill/sun/flare_tick
# 令牌补货：只在游戏进行中补（不然大厅里也会发令牌）；handout 模型一旦有非施法路径的丢失就永远补不回来
# 令牌刷出的蜜蜂 / 蝙蝠就地清掉（distance 16 覆盖刷怪蛋右键射程；只认 EntityTag 的 tag，不误伤野生的）
execute as @a[scores={kitpvp.kit=65}] at @s run kill @e[tag=kitpvp.sun_flare_token,distance=..16]
execute as @a[scores={kitpvp.kit=65}] at @s run kill @e[tag=kitpvp.sun_spot_token,distance=..16]

# 魂石：右键对应的刷怪蛋 → used 增长 → 触发一次性效果（共用蛋的类型要经过 dispatch 分流）
# 魂石：驯兽师 / 太阳 / 水星 / 金星（水星是一次性 buff，没有后续计时）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_tamer_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_tamer_last = @s kitpvp.soul_tamer_used
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_sun_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_sun_last = @s kitpvp.soul_sun_used
# 水星魂石：河豚蛋的使用统计 → 快照比较（同表渔夫）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_mercury_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_mercury_last = @s kitpvp.soul_mercury_used
# 兜底：蛋真的用掉了就会在原地生出一只带 soul_mercury_token 的河豚；
# 统计判据万一不涨（1.20.1 对刷怪蛋的 used 统计并不总是可靠），这条也能触发，use_mercury 会顺手把河豚清掉
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.soul_venus_last matches -2147483648.. run scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used
# 驯兽师 / 金星：落点 marker 与舔狗的每刻推进（太阳魂石不用 marker：标记在人身上）
execute as @e[tag=kitpvp.soul_tamer_marker] at @s run function kitpvp:skill/soul/tamer_tick
execute as @e[tag=kitpvp.soul_venus_dog] at @s run function kitpvp:skill/soul/venus_tick
# 太阳魂石：被日蚀锁定的人每刻走自己的倒计时（标记在人身上 → 跑出 10 格范围也继续吃噪音）
execute as @a[tag=kitpvp.sun_hit] run function kitpvp:skill/soul/sun_hit

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

execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=1..}] run scoreboard players remove @s kitpvp.soul_bow_timer 1
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=..0}] run function kitpvp:skill/soul/bow_expire
execute as @a[tag=kitpvp.soul_pirate_held,scores={kitpvp.soul_pirate_timer=1..}] run scoreboard players remove @s kitpvp.soul_pirate_timer 1
execute as @a[tag=kitpvp.soul_pirate_held,scores={kitpvp.soul_pirate_timer=..0}] run function kitpvp:skill/soul/pirate_expire
execute as @a[scores={kitpvp.soul_ghost_timer=1..}] run scoreboard players remove @s kitpvp.soul_ghost_timer 1
execute as @a[tag=kitpvp.soul_ghost_active,scores={kitpvp.soul_ghost_timer=..0}] run function kitpvp:skill/soul/ghost_expire
# 渔夫魂石：计时两段（380 落「无量空渔」、0 收束）与到期回收都在 soul/fisher_tick 里；带 at @s 供粒子锚定
execute as @a[tag=kitpvp.soul_fisher_active] at @s run function kitpvp:skill/soul/fisher_tick
# 火星魂石：巨人 20 秒 + 歌从最后 20 秒进；倒计时与提前收场都在 soul/mars_tick 里
execute as @a[tag=kitpvp.soul_mars_active] at @s run function kitpvp:skill/soul/mars_tick
execute as @a[scores={kitpvp.ghost_minion_cd=1..}] run scoreboard players remove @s kitpvp.ghost_minion_cd 1

# 烛之武（kit 97）：辞令状态每刻重挂修饰符，到点摘除
execute as @a[tag=kitpvp.cz_buff] run function kitpvp:skill/zhuzhiwu/buff_tick
