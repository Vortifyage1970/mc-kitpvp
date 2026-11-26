# 起播：歌曲 + 歌词都来自存档里的独立数据包 rumbling（不在 git 里）
# 单独一个函数，是为了让"没装 rumbling"的存档也能正常放地鸣 —— 缺包时只有这一份加载失败，
# 调用方 domain_cast 只是安静地跳过音乐，巨人照常出现（见 04 §十）
execute as @a run function kitpvp:music/rumbling/play
function kitpvp:music/rumbling_lyric/start
