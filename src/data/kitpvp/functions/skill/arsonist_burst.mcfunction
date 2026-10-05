# ===== 纵火狂：燃烧瓶即将落地 =====
# 触发：tick.mcfunction 检测到带 KitFireBomb 标记的药水"下方 0.5 格不再是空气"
#       （喷溅药水撞地即碎，只能在碎片前一刻捕捉落点）
# @s = 药水实体

# 防止同一次投掷被连续两刻重复触发
tag @s add kitpvp.arsonist_burst

playsound minecraft:item.firecharge.use master @a ~ ~ ~ 0.8 0.8

# align xyz：把执行位置向下取整对齐到落点所在方块，
#           此后 arsonist_place 里的相对坐标才是整数格的
# （align 是 1.19.4 加入的 execute 子命令，1.20.1 可用）
execute align xyz run function kitpvp:skill/arsonist_place