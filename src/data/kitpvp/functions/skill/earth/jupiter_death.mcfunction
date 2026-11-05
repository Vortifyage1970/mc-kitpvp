# @s = 木星的"守卫"标记（隐形 marker）：木星已经不在了，就在守卫脚下劈一道雷，然后自毁
# 守卫不依赖尸体的任何一帧：被砍死、被箭射死、被 /kill、被清场都会炸
# 例外是 game/reset：清场前先 kill 掉守卫，所以终局不会满场放雷（顺序不能反）
summon minecraft:lightning_bolt ~ ~ ~
kill @s
