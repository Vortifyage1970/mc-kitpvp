# 隐匿者放烟花：每 5 秒一枚，黑色星爆 + 拖尾 + 闪烁；Silent 让它别出声（不然满地图都是"嘭"）
# Colors/FadeColors 是 24 位 RGB，黑色 = 0（一个整数就够，写多个等于多份同色）；Type 2b = 星形；LifeTime 20 刻 ≈ 1 秒后炸开
scoreboard players set @s kitpvp.earth_cd_a 100
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:20,Fireworks:{Flight:1b,Explosions:[{Type:2b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}
