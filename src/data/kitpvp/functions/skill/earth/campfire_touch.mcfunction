# @s = 刚打了篝火一下的玩家（advancement 驱动，只看"伤害来源是篝火"，摔伤/别的怪打中不会触发）
# ★ 玩家不能用 /data merge 改 NBT（1.20.1 会报 "Unable to modify player data"），所以 Fire 那条路走不通。
#   改成自己记一个 burn_left 计时器，由 tick 每刻推进：每 20 刻掉 1 点火焰伤害、每刻冒火星。
scoreboard players set @s kitpvp.burn_left 100
# 一声点火的"嗤"，贴着耳朵给本人
playsound minecraft:item.firecharge.use master @s ~ ~ ~ 0.9 1.2
