# 地球·69 飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉地上的 lead + 每 10 秒俯冲 17 格
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_flyer_carrier] at @s 调用
# 共生：吊舱死则母体死。但出生后前 10 刻不算（吊舱要等下一帧才召得出来）
execute if score @s kitpvp.flyer_grace matches ..0 unless entity @e[tag=kitpvp.earth_flyer_body] run kill @s
execute if score @s kitpvp.flyer_grace matches 1.. run scoreboard players remove @s kitpvp.flyer_grace 1
execute as @e[tag=kitpvp.earth_flyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900010,1,1,1]}}
execute as @e[tag=kitpvp.earth_flyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 目标：优先"非召唤者"；只剩召唤者在线时退化为扑最近的玩家，否则单机测试时它永远不会动
scoreboard players operation #fl_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.flyer_target] remove kitpvp.flyer_target
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #fl_own kitpvp.game run tag @s add kitpvp.flyer_target
execute unless entity @a[tag=kitpvp.flyer_target] as @a[gamemode=!spectator,tag=!kitpvp.spectator] run tag @s add kitpvp.flyer_target
# 限高：母体最多比目标玩家高 10 格（原版幻翼盘旋时会一圈圈往上爬，爬太高绳子够不到、也看不清）
# 写法：以玩家为原点看母体的 dy，超过 10 格就往下降 1 格/刻（幻翼自己上升只有 0.05/刻，压得住）
execute at @p[tag=kitpvp.flyer_target] as @e[tag=kitpvp.earth_flyer_carrier,dy=10..] at @s run tp @s ~ ~-1 ~
# 每 200 刻（10 秒）扑一次：先设 17 刻的俯冲倒计时，再冲 17 格（1 格/刻）
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.flyer_dive 17
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
execute if score @s kitpvp.flyer_dive matches 1.. if entity @a[tag=kitpvp.flyer_target] facing entity @p[tag=kitpvp.flyer_target] feet run tp @s ^ ^ ^1
# 兜底：一个人都没有（或全在旁观）时垂直往下冲，至少能看见它动
execute if score @s kitpvp.flyer_dive matches 1.. unless entity @a[tag=kitpvp.flyer_target] run tp @s ~ ~-1 ~
# ★ 俯冲这 17 刻里把吊舱一起搬走：原版"生物持绳"超过约 10 格必断，17 格冲刺不可能靠绳子拽住
#   顺序很关键：先在上一行把母体挪到新位置，再让吊舱跟到"新位置的下方 2 格"，两者距离恒为 2 ⇒ 绳子全程不断
execute if score @s kitpvp.flyer_dive matches 1.. at @s run tp @e[tag=kitpvp.earth_flyer_body,limit=1,sort=nearest] ~ ~-2 ~
execute if score @s kitpvp.flyer_dive matches 1.. run scoreboard players remove @s kitpvp.flyer_dive 1
