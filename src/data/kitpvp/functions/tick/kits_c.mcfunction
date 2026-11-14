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
execute as @a[scores={kitpvp.kit=71,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/pluto/follow
# 鹦鹉一死 => 本体强制死亡；重生后由 player/after_death 补一只新鹦鹉
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=71,kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] at @s run function kitpvp:skill/pluto/check
# 大厅里没有 after_death 兜底（on_death 只在局内挂 respawn_pending）：鸟丢了就在大厅直接补一只
execute if score #state kitpvp.game matches 0 as @a[scores={kitpvp.kit=71},tag=!kitpvp.spectator] at @s run function kitpvp:skill/pluto/respawn

# 令牌刷出来的基础生物：蛋一用就会刷一只，兜底清（cast 里已当场清过一次）
kill @e[tag=kitpvp.venus_token]

