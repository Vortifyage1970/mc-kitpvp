# 自身速度 I 5 秒；其他存活玩家发光 5 秒。选择器里比不了身份，用同刻自清的临时 tag 把自己摘出去
effect give @s minecraft:speed 5 0 true

tag @s add kitpvp.werewolf_sniff_self
effect give @a[tag=!kitpvp.spectator,tag=!kitpvp.werewolf_sniff_self] minecraft:glowing 5 0 true
tag @s remove kitpvp.werewolf_sniff_self

title @s actionbar {"text":"嗅闻：5 秒速度 I，猎物全体发光","color":"gray"}
playsound minecraft:entity.wolf.ambient master @s ~ ~ ~ 0.8 1.2

# 用一个就进补货计时：满仓用掉一个也要等满 25 秒才补回来。
# ..0 守卫：计时中再用不重置，否则连续嗅闻会把补货推得越来越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 500
