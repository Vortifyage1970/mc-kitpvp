# @s = 火球（执行位置就在命中点）：结算 4 点魔法伤害，然后炸掉自己
# 想让目标"烧起来"不能用 /data 改玩家的 Fire（玩家数据不允许 data 命令修改），只能 setblock fire（会留火、会蔓延）——这里用火焰粒子代替，不做点燃
# 只打 kitpvp.bw_cur 的人：那套 tag 由 babywhelp_ball 每刻重建，已经排除了创造 / 旁观 / 观战 / 召唤者本人
# 有主就按"生物攻击"结算（归还击杀与伤害归属）；宝宝已经不在了就退化成无来源伤害
execute if entity @e[tag=kitpvp.earth_babywhelp,distance=..48] as @a[tag=kitpvp.bw_cur,distance=..1.7] at @s run damage @s 4 minecraft:magic by @e[tag=kitpvp.earth_babywhelp,distance=..48,limit=1]
# ⚠ `/damage` 的 target 只收**单个**实体（EntityArgument.entity）：写 `damage @a[...] …` 会让整个函数解析失败、一行都不注册（踩过）
execute unless entity @e[tag=kitpvp.earth_babywhelp,distance=..48] as @a[tag=kitpvp.bw_cur,distance=..1.7] run damage @s 4 minecraft:magic
particle minecraft:explosion ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~ ~ 0.25 0.25 0.25 0.03 6
playsound minecraft:entity.generic.explode hostile @a[distance=..16] ~ ~ ~ 0.8 1.2
kill @s
