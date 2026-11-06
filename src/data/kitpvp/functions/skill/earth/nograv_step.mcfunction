# @s = 一只无重力召唤物（无重力僵尸 / 深池飞行兵），at 它身上：朝最近的"不是它主人"的玩家走一步
# ★ 追主人是最大的坑：以前选目标是"最近的玩家"，主人贴身跟随时它就是跟着主人转圈，
#   敌人站在 5、6 格外观望永远够不到 —— 这就是"很难打到人"。现在先把主人挂临时 tag kitpvp.nograv_owner，
#   选目标时用 tag=!kitpvp.nograv_owner 排除掉，它就会朝敌人飞过去；没有主人的召唤物则谁都追。
# ★ 24 格内每刻沿视线挪 0.16 格（≈3.2 格/秒），不做方块检查 ⇒ 会穿墙（刻意的，卡墙手感更糟）
# ★ 只追活着的玩家：观战者（gamemode 3 / kitpvp.spectator）与尸体不算目标
# ★ 兜底：玩家跑到 24 格以外才直接贴过去（刚召唤 / 玩家传送走），不是日常移动
scoreboard players set #ng_owner kitpvp.game 0
scoreboard players operation #ng_owner kitpvp.game = @s kitpvp.earth_owner
tag @a remove kitpvp.nograv_owner
execute if score #ng_owner kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #ng_owner kitpvp.game run tag @s add kitpvp.nograv_owner
execute if entity @p[distance=1.2..24,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.nograv_owner] facing entity @p[distance=1.2..24,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.nograv_owner] feet run tp @s ^ ^ ^0.16
execute unless entity @p[distance=..24,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.nograv_owner] if entity @p[distance=24..64,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.nograv_owner] run tp @s @p[distance=24..64,sort=nearest,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.nograv_owner]
tag @a remove kitpvp.nograv_owner
