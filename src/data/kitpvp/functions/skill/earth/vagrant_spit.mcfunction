# 流浪汉吐口水：由 advancement kitpvp:player/vagrant_spit 触发（@s = 真的打了流浪汉的那名玩家）
# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次，不 revoke 下次就不再触发
advancement revoke @s only kitpvp:player/vagrant_spit
# 只在玩家打了这只流浪汉时进这里 —— 不像旧的 tick 那套"挨打 + 3 格内有流浪汉"，站在旁边的人不会被误伤
# 排查用计数：每次 +1（/scoreboard players get @s kitpvp.earth_hit_hits）
scoreboard players add @s kitpvp.earth_hit_hits 1

# 只给一瓶"口水"：普通药水（饮用型），喝下去反胃 10 秒 = 200 刻；水做底，效果走 CustomPotionEffects
give @s minecraft:potion{Potion:"minecraft:water",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200}],display:{Name:'{"text":"口水","color":"dark_green","italic":false}'}} 1