# 幂等发放寻戟令牌（溺尸刷怪蛋，KitFisherEgg:1b）。
# 触发走 used 统计（不依赖载体），载体纯粹是"蛋生出来的那只怪"，必须打 tag 方便清：
# 原来按 name="寻戟" + 16 格清，海洋图里它会游走 / 渔夫死后没人清 → 跨局残留（2026-11-26 实机）
execute unless data entity @s Inventory[{tag:{KitFisherEgg:1b}}] run give @s minecraft:drowned_spawn_egg{KitFisherEgg:1b,EntityTag:{Tags:["kitpvp.fisher_token"],NoAI:1b,Silent:1b},display:{Name:'{"text":"寻戟","color":"blue"}'}} 1
