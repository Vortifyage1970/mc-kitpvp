# 君士坦丁堡：9 张模板按 3×3 拼回整图，原点 = -58 57 -5046 起，x 每列 +48、z 每行 +48。
# 世界里的保存用结构方块（mode=SAVE）记录的正是这 9 个原点，别按"沿 z 排 9 块"去理解。
# 地图本体是 104×108：只有第 3 列 8 格、第 3 行 12 格有方块，所以 cobblestone3/6/9 很薄。
# 模板只存方块（导出时关掉「包含实体」，导出角点上的 structure_block 也已剥掉），故不需要 decor。
# 复原固定三步的前两步（见 04 §七）：① 按 3×3 并集清空实体 ② place 方块
kill @e[x=-58,y=57,z=-5046,dx=144,dy=96,dz=144]
place template kitpvp:cobblestone1 -58 57 -5046
place template kitpvp:cobblestone2 -10 57 -5046
place template kitpvp:cobblestone3 38 57 -5046
place template kitpvp:cobblestone4 -58 57 -4998
place template kitpvp:cobblestone5 -10 57 -4998
place template kitpvp:cobblestone6 38 57 -4998
place template kitpvp:cobblestone7 -58 57 -4950
place template kitpvp:cobblestone8 -10 57 -4950
place template kitpvp:cobblestone9 38 57 -4950
