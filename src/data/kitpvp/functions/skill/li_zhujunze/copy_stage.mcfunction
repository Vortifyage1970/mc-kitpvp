# 第 3 秒：每只 iLsacuL 原地生出一只 200 血的复制体
# ⚠ 封顶 16 只：以前无上限翻倍，一局里能滚到几百只，实体数直接打爆服务器
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches ..15 as @e[tag=kitpvp.li_pig] at @s run function kitpvp:summon/li_pig_copy
