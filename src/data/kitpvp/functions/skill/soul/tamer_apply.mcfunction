# 驯兽师魂石落地（执行位置 = 落点，@s = 使用者）
# 落点插一个 marker：20 秒（400 刻）倒计时，每 5 秒（100 刻）一波，共 4 波
# 每波 = 1 只已驯服的狗 + 4 只随机动物（狗以外的驯兽师可召唤动物），总计 4 只狗 + 16 只动物
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_tamer_marker","kitpvp.soul_tamer_new"]}
scoreboard players set @e[tag=kitpvp.soul_tamer_new] kitpvp.soul_timer 400
scoreboard players set @e[tag=kitpvp.soul_tamer_new] kitpvp.soul_next 0
tag @e[tag=kitpvp.soul_tamer_new] remove kitpvp.soul_tamer_new

title @s actionbar {"text":"魂石·兽群：20 秒内每 5 秒一波（4 狗 + 16 兽）","color":"green"}
playsound minecraft:entity.wolf.howl master @s ~ ~ ~ 1.0 1.0
