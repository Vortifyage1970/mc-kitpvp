# 位置 = 玩家脚下：先把这一对里的缓慢清干净，再只给最近的那节上缓慢 III
# 每刻刷新、只挂 1 秒 ⇒ 谁往前站谁被拖慢，换位时立刻交换；玩家跑出 40 格两边都会自然过期
effect clear @e[tag=kitpvp.earth_tanden,distance=..40] minecraft:slowness
effect give @e[tag=kitpvp.earth_tanden,distance=..40,sort=nearest,limit=1] minecraft:slowness 1 2 true
