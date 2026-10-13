# 首行无条件推进 last；投掷入口的调用条件里不能加 hold_ep_prev（见 05 §12）
scoreboard players operation @s kitpvp.ender_last = @s kitpvp.ender_used

execute if entity @s[tag=kitpvp.hold_ep_prev] run function kitpvp:skill/enderman_fire
