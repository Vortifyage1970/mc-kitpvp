# 剑不在主手：挂上等待标记，蓄力保持 3 点不消耗
tag @s add kitpvp.ench_wait
execute unless score @s kitpvp.ench_hint matches 1.. run title @s actionbar [{"text":"剑附魔已满，把金剑拿在主手才会升级","color":"yellow"}]
scoreboard players set @s kitpvp.ench_hint 40
