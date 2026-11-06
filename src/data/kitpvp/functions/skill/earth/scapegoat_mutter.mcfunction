# @s = 借调员工：每 30 秒主动认领一件跟自己毫无关系的事（纯文本，没有任何效果）
scoreboard players set @s kitpvp.scapegoat_cd 600
scoreboard players set #sg_line kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_line kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_line kitpvp.game 2
execute if score #sg_line kitpvp.game matches 0 run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"上次那个线上事故……其实是我干的。","color":"gray","italic":true}]
execute if score #sg_line kitpvp.game matches 1 run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"这个季度 KPI 没达标，是我干的。","color":"gray","italic":true}]
execute if score #sg_line kitpvp.game matches 2 run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"会议纪要写错了，也是我。","color":"gray","italic":true}]
execute if score #sg_line kitpvp.game matches 3 run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"打印机又卡纸了，还是我。","color":"gray","italic":true}]
