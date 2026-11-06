# @s = 音符盒的死亡守卫：本体已经不在 3 格内了 ⇒ 在原地播连音，并自毁
scoreboard players set #nb_death kitpvp.game 0
schedule function kitpvp:skill/earth/noteblock_cascade 2t append
particle minecraft:note ~ ~0.5 ~ 0.4 0.4 0.4 1 12
kill @s
