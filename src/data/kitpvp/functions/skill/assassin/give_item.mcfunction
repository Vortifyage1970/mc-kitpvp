# 幂等发放隐匿令牌（末影人刷怪蛋，KitAssassinEgg:1b）
# 载体打了 tag + NoAI：末影人默认会随机瞬移，2 刻的判定窗口里可能已经跑出 8 格判不到；
# 清理由 skill/assassin/cast 按 tag 做，reset_entities 兜底（gen_cleanup 自动收录）
execute unless data entity @s Inventory[{tag:{KitAssassinEgg:1b}}] run give @s minecraft:enderman_spawn_egg{KitAssassinEgg:1b,EntityTag:{Tags:["kitpvp.assassin_token"],NoAI:1b,Silent:1b},display:{Name:'{"text":"隐匿","color":"dark_purple"}'}} 1
