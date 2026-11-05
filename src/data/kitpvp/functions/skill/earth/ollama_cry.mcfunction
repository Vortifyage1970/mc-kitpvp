# Ollama 挨打时的输出：学命令行登录 ollama 的样子，把标点羊驼打一遍给全体看
# 真身是 skill/earth/ollama_banner（换形状只改那一个文件）
# 节流：earth_cd_a 40 刻（2 秒）内只喊一次，否则连挨几下会把聊天框刷满
# 分数不存在时 unless 自然成立（第一次挨打照样能喊），喊完由这行创建分数
execute unless score @s kitpvp.earth_cd_a matches 1.. run function kitpvp:skill/earth/ollama_banner
execute unless score @s kitpvp.earth_cd_a matches 1.. run scoreboard players set @s kitpvp.earth_cd_a 40
