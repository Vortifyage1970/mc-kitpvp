# 核弹与假核弹的共用外观：名字、血量、引信、提示全都一样，唯一区别是 ExplosionRadius
# 40 血要同时写 max_health 属性，否则 Health:40 会被原版上限 20 压回去
# 半径 63（不是 byte 最大）：覆盖范围够大，又不会把整张图都算进爆风
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.bomb","kitpvp.bomb_nuke"],CustomName:'{"text":"核弹","color":"red"}',CustomNameVisible:1b,ignited:1b,Fuse:100s,ExplosionRadius:63b,Attributes:[{Name:"minecraft:generic.max_health",Base:40}],Health:40f}
function kitpvp:summon/bomber_nuke_warn
