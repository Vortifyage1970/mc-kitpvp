# 假核弹：外观 / 提示 / 血量 / 引信与核弹完全一致，只把半径改成 0 —— 一声闷响，不掉血也不炸方块
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.bomb","kitpvp.bomb_fake"],CustomName:'{"text":"核弹","color":"red"}',CustomNameVisible:1b,ignited:1b,Fuse:100s,ExplosionRadius:0b,Attributes:[{Name:"minecraft:generic.max_health",Base:40}],Health:40f}
function kitpvp:summon/bomber_nuke_warn
