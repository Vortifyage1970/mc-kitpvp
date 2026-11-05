# Ollama 挨打时：先来一声山羊尖叫，再从 5 份素材里随机抽一份贴到聊天框（三张字符画 + 两种两端颜文字），各约 20%
# 尖叫用 goat.screaming.hurt 并把 pitch 抬到 1.35：羊驼被打了"咩"一声，pitch 越高越像受惊
# 节流：earth_cd_a 40 刻（2 秒）内只喊一次；不打节流连挨两下就会刷屏
# 分数不存在时 unless 自然成立（第一次挨打照样能喊），喊完由下面那行创建分数
execute unless score @s kitpvp.earth_cd_a matches 1.. at @s run playsound minecraft:entity.goat.screaming.hurt master @a[distance=..24] ~ ~ ~ 1.0 1.35
execute unless score @s kitpvp.earth_cd_a matches 1.. run function kitpvp:skill/earth/ollama_banner
execute unless score @s kitpvp.earth_cd_a matches 1.. run scoreboard players set @s kitpvp.earth_cd_a 40
