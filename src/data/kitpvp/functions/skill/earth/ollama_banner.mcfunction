# Ollama 挨打时的输出：只有 5 份素材，掷一次平均抽一份
# 0/1/2 = 三张字符画（围观体 / 新东方神兽 / 史诗之宠），3/4 = 两端颜文字两种
# 概率：0..127 对 5 取模 ⇒ 0/1/2 是 26/128≈20.3%，3/4 是 25/128≈19.5%（128 除不尽 5，只能这么近似）
# 排查：抽到的编号留在 #ob_rng 上，游戏里 /scoreboard players get #ob_rng kitpvp.game 直接看
scoreboard players set #ob_pool kitpvp.game 5
scoreboard players set #ob_rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 64
scoreboard players operation #ob_rng kitpvp.game %= #ob_pool kitpvp.game

# 0/1/2：三张字符画（各自末尾带 ollama run）
execute if score #ob_rng kitpvp.game matches 0 run function kitpvp:skill/earth/ollama_banner_1
execute if score #ob_rng kitpvp.game matches 1 run function kitpvp:skill/earth/ollama_banner_2
execute if score #ob_rng kitpvp.game matches 2 run function kitpvp:skill/earth/ollama_banner_3

# 3/4：两端颜文字
execute if score #ob_rng kitpvp.game matches 3 run tellraw @a [{"text":"（　・ェ・）（・ェ・　）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 4 run tellraw @a [{"text":"（＊´ｪ`＊）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 3.. run tellraw @a [{"text":"ollama run","color":"white"}]
