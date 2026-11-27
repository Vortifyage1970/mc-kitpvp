# 守护：四件保护 +5 ≈ 上限 80%，20 秒
effect give @s minecraft:resistance 20 3 true
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"守护","color":"gold","bold":true},{"text":"（全套保护 +5 · 20 秒）","color":"gray"}]
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.8 1.3
