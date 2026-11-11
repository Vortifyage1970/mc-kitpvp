# 低空飞行器的吊舱骷髅射一箭：@s = 吊舱（earth_lowflyer_body）
# 由 lowflyer_tick 在 earth_cd_a 归零时调用，射完把冷却设回 40 刻（2 秒）
# ★ 不打召唤者：lf_summoner=1 是召唤当刻的记号；有主时再把主人按 etid 排掉
scoreboard players set @s kitpvp.earth_cd_a 40
scoreboard players operation #lf_o kitpvp.game = @s kitpvp.earth_owner

tag @a remove kitpvp.lf_victim
# 16 格内的活人，先排掉召唤者
execute as @a[distance=..16,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.lf_summoner matches 1 run tag @s add kitpvp.lf_victim
# 有主（1..6）时，主人本人也不算目标
execute if score #lf_o kitpvp.game matches 1.. as @a[tag=kitpvp.lf_victim] if score @s kitpvp.etid = #lf_o kitpvp.game run tag @s remove kitpvp.lf_victim

# 有目标才放箭：声音 + 命中点火花 + 3 点 arrow 伤害（不回血、不击退）
execute if entity @a[tag=kitpvp.lf_victim] run playsound minecraft:entity.arrow.shoot master @a[distance=..24] ~ ~ ~ 1.0 1.1
execute at @s if entity @a[tag=kitpvp.lf_victim,limit=1,sort=nearest] run particle minecraft:crit ~ ~1 ~ 0.1 0.1 0.1 0.02 6
execute at @s as @a[tag=kitpvp.lf_victim,limit=1,sort=nearest] run damage @s 3 minecraft:arrow by @e[tag=kitpvp.earth_lowflyer_body,distance=..20,limit=1,sort=nearest]

tag @a remove kitpvp.lf_victim
