# 喷溅药水撞地即碎，只能在"下方不再是空气"的前一刻捕捉落点
tag @s add kitpvp.arsonist_burst

playsound minecraft:item.firecharge.use master @a ~ ~ ~ 0.8 0.8

# align xyz 把执行位置对齐到落点方块，arsonist_place 的相对坐标才是整数格
execute align xyz run function kitpvp:skill/arsonist/place
