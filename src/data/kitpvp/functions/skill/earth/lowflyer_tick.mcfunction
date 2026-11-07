# 地球·73 低空飞行器：共生（吊舱死则母体死）+ 补绳 + 清掉地上的 lead + 每 10 秒俯冲 14 格 + 没靶子时贴着召唤者
# 由 tick.mcfunction 以 as @e[tag=kitpvp.earth_lowflyer_carrier] at @s 调用
# 出生当刻不算共生：吊舱是 1 刻后才召的。用 tag 而不是计分（计分没 /reload 就不存在，会永远不判死）
execute unless entity @s[tag=kitpvp.lf_spawning] unless entity @e[tag=kitpvp.earth_lowflyer_body] run kill @s
tag @s remove kitpvp.lf_spawning
execute as @e[tag=kitpvp.earth_lowflyer_body] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900011,1,1,1]}}
execute as @e[tag=kitpvp.earth_lowflyer_body] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# 俯冲目标：不是召唤者的最近玩家（用临时 tag 筛，免得把绳子往自己脸上甩）
# 先垫 -1 再取：母体没有 earth_owner（直接 /function 召、魂石召）时那句会静默失败，
# 不垫的话 #lf_own 会留着上一次的值，可能把某个真人错当成召唤者排除掉
scoreboard players set #lf_own kitpvp.game -1
scoreboard players operation #lf_own kitpvp.game = @s kitpvp.earth_owner
tag @a[tag=kitpvp.lf_target] remove kitpvp.lf_target
# ★ 只有 owner ≥ 1 才排除召唤者。etid 0 = "还没分到槽位"（见 link.mcfunction），
#   直接 /function 召的母体 owner 也是 0，两边一相等就把唯一那个玩家排除了 ⇒ 一个靶子都没有、俯冲空转。
execute if score #lf_own kitpvp.game matches 1.. as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #lf_own kitpvp.game run tag @s add kitpvp.lf_target
execute unless score #lf_own kitpvp.game matches 1.. as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.lf_target
# 没靶子时别放任原版乱飞（蝙蝠会挂在墙上、躲进洞里）：朝召唤者慢慢靠，回到 10 格内就停手
tag @a[tag=kitpvp.lf_home] remove kitpvp.lf_home
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score @s kitpvp.etid = #lf_own kitpvp.game run tag @s add kitpvp.lf_home
execute unless entity @a[tag=kitpvp.lf_target] if entity @p[tag=kitpvp.lf_home,distance=10..] facing entity @p[tag=kitpvp.lf_home] feet run tp @s ^ ^ ^0.35
# 每 200 刻（10 秒）扑一次，上限 14 刻 × 1 格/刻（巡航只有 10 格，冲 14 格足够贴脸）；离目标 3 格内收手
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.lf_dive 14
execute if score @s kitpvp.earth_cd_a matches ..0 run scoreboard players set @s kitpvp.earth_cd_a 200
# ★ 吊舱跟着一起下：原版持绳超过约 10 格就 dropLeash，俯冲必然闪断 ⇒ 骷髅留在半空、够不到人
execute if score @s kitpvp.lf_dive matches 1.. run tp @e[tag=kitpvp.earth_lowflyer_body] ~ ~-1 ~
execute if score @s kitpvp.lf_dive matches 1.. if entity @p[tag=kitpvp.lf_target,distance=3..] facing entity @p[tag=kitpvp.lf_target] eyes run tp @s ^ ^ ^1
execute if score @s kitpvp.lf_dive matches 1.. run scoreboard players remove @s kitpvp.lf_dive 1
