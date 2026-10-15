# 发 1 个狼蛋。与狼人的嗅闻令牌共用 minecraft:wolf_spawn_egg：
# 认物品靠 KitTamerEgg:1b，认刷出来的那只狼靠 EntityTag 打的 kitpvp.tamer_wolf（狼人那只打的是 kitpvp.werewolf_token）。
# 刻意不给 display.Name：刷怪蛋的 display.Name 会变成生成生物的 CustomName，狼会顶着"狼蛋"这个名字满场跑。
give @s minecraft:wolf_spawn_egg{KitTamerEgg:1b,EntityTag:{Tags:["kitpvp.tamer_wolf"]}} 1
