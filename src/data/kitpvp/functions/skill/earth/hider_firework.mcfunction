# 隐匿者放烟花：每 5 秒一枚黑色烟花，贴着地面（约 2 格高）就炸开
# 原版烟花的"爆炸半径"是写死的，NBT 里没有可以放大的参数 ⇒ 大团黑烟用 particle 自己铺，烟花只负责那一下"闪"
scoreboard players set @s kitpvp.earth_cd_a 100

# 1) 真烟花：LifeTime 4 刻 ⇒ 刚起飞就炸，正好在头顶两格（Colors [I;0] = 黑）
summon minecraft:firework_rocket ~ ~1 ~ {Tags:["kitpvp.earth_firework"],Silent:1b,Life:0,LifeTime:4,Fireworks:{Flight:1b,Explosions:[{Type:2b,Colors:[I;0],FadeColors:[I;0],Trail:1b,Twinkle:1b}]}}

# 2) 在爆点埋一个标记：4 刻后由 hider_smoke 在它身上铺黑烟（schedule 出来的函数没有位置，只能靠标记定位）
summon minecraft:marker ~ ~2 ~ {Tags:["kitpvp.earth_fw_mark"]}
schedule function kitpvp:skill/earth/hider_smoke 4t replace
