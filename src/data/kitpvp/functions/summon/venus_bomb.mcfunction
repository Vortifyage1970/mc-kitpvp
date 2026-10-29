# 自爆模块的苦力怕：Fuse 0 + ignited → 下一 tick 立即爆炸，原地无前摇
# mobGriefing 已关，炸不坏地形，只对实体造成正常苦力怕级别的伤害
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.venus_bomb_creeper"],ignited:1b,Fuse:0s,ExplosionRadius:3b}
