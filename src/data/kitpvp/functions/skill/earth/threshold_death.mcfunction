# @s = 门槛哥脚下的隐形 marker。本体没了（砍死 / 掉虚空 / /kill）就在这儿立一扇门，然后自毁
# 门的上下两格必须一起放：只放下半截会缺一半，看着像"半个门框"
# 两步走：① keep（只往空气里放，不破坏地形）② 如果那一格是"可替换"的软方块（雪片 / 短草 / 藤蔓 / 水），再 replace 一次
#   ★ 只写 keep 的坑：站在雪原的雪片层、草丛、藤蔓里死时，脚下不是空气 ⇒ 下半截被跳过 ⇒ 只剩上半截悬在半空
#   这就是"门只有上半格"的真正原因
setblock ~ ~ ~ minecraft:dark_oak_door[half=lower,facing=north,hinge=left,open=false,powered=false] keep
execute if block ~ ~ ~ #minecraft:replaceable unless block ~ ~ ~ minecraft:dark_oak_door run setblock ~ ~ ~ minecraft:dark_oak_door[half=lower,facing=north,hinge=left,open=false,powered=false] replace
setblock ~ ~1 ~ minecraft:dark_oak_door[half=upper,facing=north,hinge=left,open=false,powered=false] keep
execute if block ~ ~1 ~ #minecraft:replaceable unless block ~ ~1 ~ minecraft:dark_oak_door run setblock ~ ~1 ~ minecraft:dark_oak_door[half=upper,facing=north,hinge=left,open=false,powered=false] replace
playsound minecraft:block.wooden_door.open master @a[distance=..24] ~ ~ ~ 1.0 0.9
playsound minecraft:block.wooden_door.close master @a[distance=..24] ~ ~ ~ 0.9 0.8
kill @s
