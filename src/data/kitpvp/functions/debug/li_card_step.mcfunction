# 逐刻抽卡测试的分发：按 #li_step 打第 N 张卡，然后 +1 并排下一刻
execute if score #li_step kitpvp.game matches 0 run function kitpvp:skill/li_ench/card/c00_mo
execute if score #li_step kitpvp.game matches 1 run function kitpvp:skill/li_ench/card/c01_cui
execute if score #li_step kitpvp.game matches 2 run function kitpvp:skill/li_ench/card/c02_str
execute if score #li_step kitpvp.game matches 3 run function kitpvp:skill/li_ench/card/c03_spd
execute if score #li_step kitpvp.game matches 4 run function kitpvp:skill/li_ench/card/c04_res
execute if score #li_step kitpvp.game matches 5 run function kitpvp:skill/li_ench/card/c05_haste
execute if score #li_step kitpvp.game matches 6 run function kitpvp:skill/li_ench/card/c10_fine_sw
execute if score #li_step kitpvp.game matches 7 run function kitpvp:skill/li_ench/card/c11_fine_ap
execute if score #li_step kitpvp.game matches 8 run function kitpvp:skill/li_ench/card/c12_sharp3
execute if score #li_step kitpvp.game matches 9 run function kitpvp:skill/li_ench/card/c13_prot2
execute if score #li_step kitpvp.game matches 10 run function kitpvp:skill/li_ench/card/c14_heal4
execute if score #li_step kitpvp.game matches 11 run function kitpvp:skill/li_ench/card/c15_cd5s
execute if score #li_step kitpvp.game matches 12 run function kitpvp:skill/li_ench/card/c20_level
execute if score #li_step kitpvp.game matches 13 run function kitpvp:skill/li_ench/card/c21_egg
execute if score #li_step kitpvp.game matches 14 run function kitpvp:skill/li_ench/card/c22_sharp5
execute if score #li_step kitpvp.game matches 15 run function kitpvp:skill/li_ench/card/c23_heal10
execute if score #li_step kitpvp.game matches 16 run function kitpvp:skill/li_ench/card/c24_prot5
execute if score #li_step kitpvp.game matches 17 run function kitpvp:skill/li_ench/card/c25_souls
scoreboard players add #li_step kitpvp.game 1
execute if score #li_step kitpvp.game matches ..17 run schedule function kitpvp:debug/li_card_step 3t replace
execute if score #li_step kitpvp.game matches 18.. run function kitpvp:debug/li_card_done
