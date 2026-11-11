# 发 1 个嗅闻令牌（狼刷怪蛋）。EntityTag 把 tag 直接打进刷出来的那只狼，认它比认 display.Name 稳（同里·弓箭手炮台令牌）
# 不判"背包里有没有"：补货闸门在上限与冷却上，幂等守卫会把上限挡死（见 04 §五）
give @s minecraft:wolf_spawn_egg{KitWerewolfEgg:1b,EntityTag:{Tags:["kitpvp.werewolf_token"]},display:{Name:'{"text":"嗅闻","color":"gray"}'}} 1
