# Ollama 挨打时的输出：6 份素材，掷一次抽一份
# 0/1/2 = 三张字符画（围观体 / 新东方神兽 / 史诗之宠）
# 3 = 第一长串颜文字（整块），4 = 第二长串颜文字（整块）—— 两串都不再做任何拆分
# 5 = 红框「该作品已删除」：抽到就是"图看不见"，纯整活
# 概率：0..127 对 6 取模 ⇒ 0/1 各 22/128≈17.2%，2..5 各 21/128≈16.4%（128 除不尽 6）
# 排查：抽到的编号留在 #ob_rng 上，游戏里 /scoreboard players get #ob_rng kitpvp.game 直接看
scoreboard players set #ob_pool kitpvp.game 6
scoreboard players set #ob_rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 64
scoreboard players operation #ob_rng kitpvp.game %= #ob_pool kitpvp.game

execute if score #ob_rng kitpvp.game matches 0 run function kitpvp:skill/earth/ollama_banner_1
execute if score #ob_rng kitpvp.game matches 1 run function kitpvp:skill/earth/ollama_banner_2
execute if score #ob_rng kitpvp.game matches 2 run function kitpvp:skill/earth/ollama_banner_3
execute if score #ob_rng kitpvp.game matches 3 run function kitpvp:skill/earth/ollama_banner_4
execute if score #ob_rng kitpvp.game matches 4 run function kitpvp:skill/earth/ollama_banner_5
execute if score #ob_rng kitpvp.game matches 5 run function kitpvp:skill/earth/ollama_banner_6
