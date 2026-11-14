# 巨人/驾驶员生命周期 + 生灵刷新节拍
# 巨人死了 → 驾驶员连坐、音乐停、生灵清场
execute unless entity @e[tag=kitpvp.mars_giant] if entity @e[tag=kitpvp.mars_controller] run function kitpvp:skill/mars/giant_end
# 驾驶员死了 → 音乐停（巨人不连坐）
execute unless entity @e[tag=kitpvp.mars_controller] if entity @e[tag=kitpvp.mars_giant] run function kitpvp:skill/mars/music_stop
# 巨人还活着 → 每 30 刻刷一只生灵
execute if entity @e[tag=kitpvp.mars_giant] run function kitpvp:skill/mars/wild_tick
