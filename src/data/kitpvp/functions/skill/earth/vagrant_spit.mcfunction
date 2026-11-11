# 流浪汉吐口水：由 advancement kitpvp:player/vagrant_spit 触发（@s = 被这只流浪汉打中的那名玩家）
# 触发器是 entity_hurt_player + damage.source_entity.nbt 匹配 Tags:["kitpvp.earth_vagrant"]
#   —— 也就是"流浪汉动手打了谁"，只算挨打的那一个；站在旁边的人不会中
# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次，不 revoke 下次就不再触发
advancement revoke @s only kitpvp:player/vagrant_spit
# 排查用计数：每次 +1（/scoreboard players get @s kitpvp.earth_hit_hits）
scoreboard players add @s kitpvp.earth_hit_hits 1

# 只给一瓶"口水"：普通药水（饮用型），喝下去反胃 10 秒 = 200 刻；水做底，效果走 CustomPotionEffects
give @s minecraft:potion{Potion:"minecraft:water",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200}],display:{Name:'{"text":"口水","color":"dark_green","italic":false}'}} 1