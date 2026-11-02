# 召唤属于 @s 的冥王星：先清同号的可见残留，再生成并把归属号写上（幂等，重复调用只有一只）
function kitpvp:skill/pluto/despawn
function kitpvp:summon/pluto_parrot
scoreboard players operation @e[tag=kitpvp.pluto_parrot_new] kitpvp.parrot_owner = @s kitpvp.ptid
tag @e[tag=kitpvp.pluto_parrot_new] remove kitpvp.pluto_parrot_new
