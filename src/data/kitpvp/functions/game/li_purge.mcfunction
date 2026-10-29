# iLsacuL 专用清除（结算 game/end 与重置 game/reset 开头各调一次）
# 为什么不能只在 reset 里 kill：落在未加载区块的猪既选不中也杀不掉，
# 会带着"没死透"的状态存进区域文件，下一局 apocalypse 逐刻重跑、苦力怕越积越多（见 04 §十四）
# 顺序：先关自爆开关 → 再把猪拉到玩家身上（那一区块必然加载）→ 再杀 → 隔刻复核
scoreboard players set #liapoc kitpvp.game 0
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #licount kitpvp.game 0

kill @e[tag=kitpvp.li_bomb]

execute if entity @a[tag=kitpvp.selected,limit=1,sort=nearest] run tp @e[tag=kitpvp.li_pig] @a[tag=kitpvp.selected,limit=1,sort=nearest]
kill @e[tag=kitpvp.li_pig]

schedule function kitpvp:game/li_purge_verify 1t replace
