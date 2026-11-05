# Ollama 挨打时的输出：从 68 份素材里随机抽一份，只打那一份
# 0..2 = 三张框线字符画（各自一整个块），3..67 = 65 行羊驼脸（每行算一份）
# 想加素材：往下面补一行、把 #ob_pool 加一；想加"整块"的多行素材就新建 ollama_banner_N 并在 0..2 后面接一个分支
# 掷骰：1in2 连掷 7 次拼 0..127，再对份数取模（和 skill/earth/random.mcfunction 同一个套路）
scoreboard players set #ob_pool kitpvp.game 68
scoreboard players set #ob_rng kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ob_rng kitpvp.game 64
scoreboard players operation #ob_rng kitpvp.game %= #ob_pool kitpvp.game

# 0..2：三张字符画
execute if score #ob_rng kitpvp.game matches 0 run function kitpvp:skill/earth/ollama_banner_1
execute if score #ob_rng kitpvp.game matches 1 run function kitpvp:skill/earth/ollama_banner_2
execute if score #ob_rng kitpvp.game matches 2 run function kitpvp:skill/earth/ollama_banner_3

# 3..67：随机到哪一行就只打那一行
execute if score #ob_rng kitpvp.game matches 3 run tellraw @a [{"text":"普通版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 4 run tellraw @a [{"text":"（　・ェ・）（・ェ・　）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 5 run tellraw @a [{"text":"煞氣a囧囧有神版!","color":"white"}]
execute if score #ob_rng kitpvp.game matches 6 run tellraw @a [{"text":"(・´ｪ`・)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 7 run tellraw @a [{"text":"認真模式版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 8 run tellraw @a [{"text":"(・`ｪ´・)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 9 run tellraw @a [{"text":"XD版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 10 run tellraw @a [{"text":"(>´ｪ`<) (>`ｪ´<)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 11 run tellraw @a [{"text":"抸眼版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 12 run tellraw @a [{"text":"(>´ｪ`o) (o`ｪ´<)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 13 run tellraw @a [{"text":"兩眼無神版?","color":"white"}]
execute if score #ob_rng kitpvp.game matches 14 run tellraw @a [{"text":"(o´ｪ`o) (o`ｪ´o)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 15 run tellraw @a [{"text":"兩眼瞪大版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 16 run tellraw @a [{"text":"(O´ｪ`O) (O`ｪ´O)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 17 run tellraw @a [{"text":"瞳孔放大版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 18 run tellraw @a [{"text":"(0´ｪ`0) (0`ｪ´0)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 19 run tellraw @a [{"text":"眼花版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 20 run tellraw @a [{"text":"(@´ｪ`@) (@`ｪ´@)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 21 run tellraw @a [{"text":"我很火大版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 22 run tellraw @a [{"text":"(ˋ´ｪ`ˊ) (ˋ`ｪ´ˊ)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 23 run tellraw @a [{"text":"我很鬱卒版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 24 run tellraw @a [{"text":"(ˊ´ｪ`ˋ) (ˊ`ｪ´ˋ)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 25 run tellraw @a [{"text":"哭哭版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 26 run tellraw @a [{"text":"(T´ｪ`T) (T`ｪ´T)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 27 run tellraw @a [{"text":"(Q´ｪ`Q) (Q`ｪ´Q)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 28 run tellraw @a [{"text":"= =版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 29 run tellraw @a [{"text":"(=´ｪ`=) (=`ｪ´=)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 30 run tellraw @a [{"text":"- -版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 31 run tellraw @a [{"text":"(-´ｪ`-) (-`ｪ´-)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 32 run tellraw @a [{"text":"(一´ｪ`一) (一`ｪ´一)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 33 run tellraw @a [{"text":"~ ~版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 34 run tellraw @a [{"text":"(~´ｪ`~) (~`ｪ´~)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 35 run tellraw @a [{"text":"愛睏版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 36 run tellraw @a [{"text":"(z´ｪ`z) (z`ｪ´z)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 37 run tellraw @a [{"text":"見錢眼開版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 38 run tellraw @a [{"text":"($´ｪ`$) ($`ｪ´$)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 39 run tellraw @a [{"text":"佐助淦掉鼬之後的寫輪眼版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 40 run tellraw @a [{"text":"(米´ｪ`米) (米`ｪ´米)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 41 run tellraw @a [{"text":"庫洛姆&六道骸版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 42 run tellraw @a [{"text":"(六´ｪ`・) (六`ｪ´・)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 43 run tellraw @a [{"text":"劍心版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 44 run tellraw @a [{"text":"(・´ｪ`・ㄨ) (・`ｪ´・ㄨ)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 45 run tellraw @a [{"text":"亞紀人、咢版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 46 run tellraw @a [{"text":"(#´ｪ`・)(・`ｪ´#)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 47 run tellraw @a [{"text":"大雄版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 48 run tellraw @a [{"text":"(3´ｪ`3) (3`ｪ´3)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 49 run tellraw @a [{"text":"七龍珠.史考特版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 50 run tellraw @a [{"text":"(口´ｪ`・)(・`ｪ´口)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 51 run tellraw @a [{"text":"戰鬥力....-999999","color":"white"}]
execute if score #ob_rng kitpvp.game matches 52 run tellraw @a [{"text":"歡迎各位踴躍投稿!","color":"white"}]
execute if score #ob_rng kitpvp.game matches 53 run tellraw @a [{"text":"aa7608 (小草〃聖誕版)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 54 run tellraw @a [{"text":"小草版","color":"white"}]
execute if score #ob_rng kitpvp.game matches 55 run tellraw @a [{"text":"（　・//ェ//・）（・//ェ//・　）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 56 run tellraw @a [{"text":"（　ˋェˊ）（ˋェˊ　）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 57 run tellraw @a [{"text":"（　ˊェˋ）（ˊェˋ　）","color":"white"}]
execute if score #ob_rng kitpvp.game matches 58 run tellraw @a [{"text":"louisroger (余欣蔚 媽媽桑)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 59 run tellraw @a [{"text":"???","color":"white"}]
execute if score #ob_rng kitpvp.game matches 60 run tellraw @a [{"text":"(´ｪ`)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 61 run tellraw @a [{"text":"萬佛朝宗???","color":"white"}]
execute if score #ob_rng kitpvp.game matches 62 run tellraw @a [{"text":"(卐´ｪ`卍)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 63 run tellraw @a [{"text":"輪迴眼","color":"white"}]
execute if score #ob_rng kitpvp.game matches 64 run tellraw @a [{"text":"(回´ｪ`回)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 65 run tellraw @a [{"text":"jaff79984 (☆×提拉米蘇°)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 66 run tellraw @a [{"text":"雪花版???(喝茫版???)","color":"white"}]
execute if score #ob_rng kitpvp.game matches 67 run tellraw @a [{"text":"（＊´ｪ`＊）","color":"white"}]

# 收尾：命令行那句（不管抽到什么都跟着打一行）
tellraw @a [{"text":"ollama run","color":"white"}]
