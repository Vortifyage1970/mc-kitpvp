# @s = 双星A 脚下的隐形 marker：A 没了（砍死 / 掉虚空 / 被 /kill）就排一个 2 秒后的检查，然后自毁
# 2 秒 = 40 刻，这就是"两只必须同时死"的判定窗口
schedule function kitpvp:skill/earth/twinstar_revive_a 40t replace
kill @s