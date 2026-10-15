# 领域展开计时：1220 → 1200 开领域 → 0 收束
execute if score @s kitpvp.tainted_fisher_domain_timer matches 1200 run function kitpvp:skill/tainted_fisher/domain_open

# 领域持续期间：每刻重挂 1 秒力量 I。死亡与重生都会清空药水效果，
# 逐刻重挂才能保证"持续期间一直有"（复活那一段也顺带覆盖）
execute if score @s kitpvp.tainted_fisher_domain_timer matches 1..1200 run effect give @s minecraft:strength 1 0 true

execute if score @s kitpvp.tainted_fisher_domain_timer matches 1.. run scoreboard players remove @s kitpvp.tainted_fisher_domain_timer 1
execute if score @s kitpvp.tainted_fisher_domain_timer matches ..0 run function kitpvp:skill/tainted_fisher/domain_end
