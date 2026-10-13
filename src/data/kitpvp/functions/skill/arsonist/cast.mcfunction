# 首行无条件推进 last；投掷入口的调用条件里不能加 hold_fb_prev（见 05 §12）
scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used

execute if entity @s[tag=kitpvp.hold_fb_prev] run function kitpvp:skill/arsonist/fire
