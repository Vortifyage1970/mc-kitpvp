# 点一格火 + 挂守护 marker（marker 不可见无碰撞，用来在 5 秒内记住这一格必须有火）
setblock ~ ~ ~ fire
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.arsonist_fire","kitpvp.arsonist_new"]}
