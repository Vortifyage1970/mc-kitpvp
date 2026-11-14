# 地鸣生命周期（#mars_active=1 期间才处理）
# 巨人死 → 驾驶员连坐 + 收场清场 + 停音乐歌词
execute if score #mars_active kitpvp.game matches 1 unless entity @e[tag=kitpvp.mars_giant] run function kitpvp:skill/mars/giant_end
# 驾驶员死（巨人还在）→ 停音乐 + 停歌词，但巨人不连坐
execute if score #mars_active kitpvp.game matches 1 unless entity @e[tag=kitpvp.mars_controller] run function kitpvp:skill/mars/music_stop
# 巨人还在 → 每 30 刻刷一只地球生灵
execute if entity @e[tag=kitpvp.mars_giant] run function kitpvp:skill/mars/wild_tick
