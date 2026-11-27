# 里·附魔师状态自检（右键令牌没反应时先跑这个）
say ——— 里·附魔师自检 ———
tellraw @s [{"text":"kit=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kit"}},{"text":"  alive=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.alive"}},{"text":"  对局状态=","color":"gray"},{"score":{"name":"#state","objective":"kitpvp.game"}}]
tellraw @s [{"text":"领域标记：","color":"gray"},{"text":"（有就是展开中）","color":"gray"}]
execute if entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"  领域展开中","color":"green"}]
execute unless entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"  未展开","color":"red"}]
tellraw @s [{"text":"剩余刻=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_t"}},{"text":"  冷却=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"}},{"text":"  免冷却次数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_ready"}}]
tellraw @s [{"text":"令牌 used=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_used"}},{"text":"  last=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_last"}}]
tellraw @s [{"text":"赌徒蛋 used=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_egg_used"}},{"text":"  last=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_egg_last"}}]
tellraw @s [{"text":"剑等级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":"  甲等级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
