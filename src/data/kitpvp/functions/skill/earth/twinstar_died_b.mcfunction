# @s = 双星B 脚下的隐形 marker：本体没了（砍死 / 掉虚空 / 被 /kill）就排一个 1.5 秒后的检查，然后自毁
# 1.5 秒 = 30 刻，这就是"两只必须同时死"的判定窗口
schedule function kitpvp:skill/earth/twinstar_revive_b 30t replace
kill @s
