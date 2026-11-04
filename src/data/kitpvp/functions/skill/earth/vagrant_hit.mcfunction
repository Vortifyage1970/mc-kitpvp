# 流浪汉打中人的结算（@s = 挨打的那个玩家，由 advancement kitpvp:player/vagrant_hit 触发）
# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次，不 revoke 就只生效一次
advancement revoke @s only kitpvp:player/vagrant_hit

# 反胃 5 秒（时长单位是秒）
effect give @s minecraft:nausea 5 0 true

# 再塞一瓶"口水"：普通药水（饮用型），喝下去反胃 10 秒 = 200 刻；水做底，效果全走 CustomPotionEffects
give @s minecraft:potion{Potion:"minecraft:water",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200}],display:{Name:'{"text":"口水","color":"green","italic":false}'}} 1
