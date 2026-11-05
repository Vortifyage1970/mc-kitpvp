# Ollama 挨打时的"命令行开场"：从三张标点图里随机挑一张打给全体看
# 概率 1/2 围观体、1/4 新东方神兽、1/4 史诗之宠（每行的 if/unless 都是独立掷一次）
# 掷骰子用仓库现成的 kitpvp:random/1in2（predicates/random/1in2.json，chance 0.5），别写成 kitpvp:1in2
# 三张图在 ollama_banner_1/2/3，各自 16~19 行 tellraw，改图只改那三个文件
# 想加第四张：新建 ollama_banner_4，把第三行拆成"再掷一次"，或者改成等概率的计数器写法
execute if predicate kitpvp:random/1in2 run function kitpvp:skill/earth/ollama_banner_1
execute unless predicate kitpvp:random/1in2 if predicate kitpvp:random/1in2 run function kitpvp:skill/earth/ollama_banner_2
execute unless predicate kitpvp:random/1in2 unless predicate kitpvp:random/1in2 run function kitpvp:skill/earth/ollama_banner_3
