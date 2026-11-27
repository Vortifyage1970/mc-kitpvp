# 四星：五个奖品等概率
scoreboard players set #li_5 kitpvp.game 5
scoreboard players operation #li_p4 kitpvp.game = #li_r4 kitpvp.game
scoreboard players operation #li_p4 kitpvp.game %= #li_5 kitpvp.game
execute if score #li_p4 kitpvp.game matches 0 run function kitpvp:skill/li_ench/pull_4soul
execute if score #li_p4 kitpvp.game matches 1 run function kitpvp:skill/li_ench/pull_4ghost
execute if score #li_p4 kitpvp.game matches 2 run function kitpvp:skill/li_ench/pull_4forester
execute if score #li_p4 kitpvp.game matches 3 run function kitpvp:skill/li_ench/pull_4astro
execute if score #li_p4 kitpvp.game matches 4 run function kitpvp:skill/li_ench/pull_4absorb
