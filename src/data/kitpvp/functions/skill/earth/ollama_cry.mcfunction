# Ollama 挨打时的输出：把"・ェ・"羊驼脸大全打一遍给全体看
# 脸谱在 skill/earth/ollama_banner（66 行，换内容只改那一个文件）
# 节流：earth_cd_a 200 刻（10 秒）内只喊一次。整份清单有 66 行，不打节流连挨两下就能把聊天框顶到底
# 分数不存在时 unless 自然成立（第一次挨打照样能喊），喊完由这行创建分数
execute unless score @s kitpvp.earth_cd_a matches 1.. run function kitpvp:skill/earth/ollama_banner
execute unless score @s kitpvp.earth_cd_a matches 1.. run scoreboard players set @s kitpvp.earth_cd_a 200
