# Ollama 挨打时的输出：从 5 份素材里随机抽一份（三张字符画 + 两种两端颜文字），各约 20%
# 素材在 skill/earth/ollama_banner（掷骰 + 分发），单张图在 ollama_banner_1/2/3
# 节流：earth_cd_a 40 刻（2 秒）内只喊一次；不打节流连挨两下就会刷屏
# 分数不存在时 unless 自然成立（第一次挨打照样能喊），喊完由这行创建分数
execute unless score @s kitpvp.earth_cd_a matches 1.. run function kitpvp:skill/earth/ollama_banner
execute unless score @s kitpvp.earth_cd_a matches 1.. run scoreboard players set @s kitpvp.earth_cd_a 40