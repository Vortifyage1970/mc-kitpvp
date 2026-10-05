# 地图重置：兜底加载区块，再放置结构
# 注意：<坐标> 要换成你保存时结构区域的"最小角"坐标
# 建议先跑一次 forceload 兜底，防止 /place 在未加载区块上失败
forceload add -256 -256 256 256

place structure kitpvp:map_desert -128 -64 -128

forceload remove -256 -256 256 256
