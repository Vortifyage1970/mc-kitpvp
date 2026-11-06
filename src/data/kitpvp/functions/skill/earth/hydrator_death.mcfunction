# 补水兵死了：在尸体脚下的位置灌一格水，并在聊天栏喊「补水啦」（@s = 跟着它走的守卫 marker）
# keep = 只在目标是空气时放下，不会把地板/装饰顶掉；站在水里死则什么也不做
setblock ~ ~ ~ minecraft:water keep
playsound minecraft:item.bucket.empty master @a[distance=..24] ~ ~ ~ 1.0 1.0
playsound minecraft:entity.generic.splash master @a[distance=..24] ~ ~ ~ 0.8 1.2
tellraw @a [{"text":"补水啦","color":"aqua","bold":true}]
kill @s
