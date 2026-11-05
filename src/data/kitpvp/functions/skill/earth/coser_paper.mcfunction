# @s = 刚挨了打的那个玩家（tick 用 HurtTime=9 抓的，只命中一帧，不会连发）
# 给一张叫「物料」的纸。注意：这里只判"32 格内有 COSER"，没有细分是不是它打的
give @s minecraft:paper{display:{Name:'{"text":"物料","color":"white","italic":false}'}} 1