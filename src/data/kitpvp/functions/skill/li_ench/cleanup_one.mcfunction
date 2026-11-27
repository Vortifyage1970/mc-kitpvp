# 里·附魔师：单人的收尾清理（选职业 / 终局 / 玩家离开时都走一遍）
# 领域标签、临时强化、赌徒之蛋标记、攻击力修饰符——只要漏一个就会跨局残留
tag @s remove kitpvp.ench_domain
tag @s remove kitpvp.ench_wait
scoreboard players set @s kitpvp.ench_domain_t 0
scoreboard players set @s kitpvp.ench_domain_ready 0
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
attribute @s minecraft:generic.attack_damage modifier remove 00000000-0000-0000-0000-0000000000a1
