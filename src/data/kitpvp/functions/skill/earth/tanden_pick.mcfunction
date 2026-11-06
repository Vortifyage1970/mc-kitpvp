# 位置 = 玩家脚下：先把这一对里的缓慢清干净，再只给最近的那节上缓慢 III
# 每 3 秒判一次、效果挂 4 秒（留 1 秒冗余，不会一闪一闪） ⇒ 谁往前站谁被拖慢，换位时立刻交换；玩家跑出 40 格两边都会自然过期
effect clear @e[tag=kitpvp.earth_tanden,distance=..40] minecraft:slowness
effect give @e[tag=kitpvp.earth_tanden,distance=..40,sort=nearest,limit=1] minecraft:slowness 4 2 true
