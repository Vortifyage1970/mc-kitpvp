# @s = 门槛哥脚下的隐形 marker。本体没了（砍死 / 掉虚空 / /kill）就在这儿立一扇门，然后自毁
# 门的上下两格必须一起放：只放下半截会缺一半，看着像"半个门框"
# keep = 只往空气里放，不会把地形或装饰覆盖掉；脚下不是空气（水里、沙里）时就不放，避免半截门卡在方块里
setblock ~ ~ ~ minecraft:dark_oak_door[half=lower,facing=north,hinge=left,open=false,powered=false] keep
setblock ~ ~1 ~ minecraft:dark_oak_door[half=upper,facing=north,hinge=left,open=false,powered=false] keep
playsound minecraft:block.wooden_door.close master @a[distance=..24] ~ ~ ~ 0.9 0.8
kill @s