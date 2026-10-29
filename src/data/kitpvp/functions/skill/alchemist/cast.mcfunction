# 首行无条件推进 last：投出的可能是别人给的喷溅药水，也必须消费掉这次投掷（见 05 §12）
scoreboard players operation @s kitpvp.alchemist_last = @s kitpvp.alchemist_used

# 冷却中又拿到一份（别人丢的）：投出去也不给效果，只把剩下的收走
execute if entity @s[tag=kitpvp.hold_pa_prev] if score @s kitpvp.cd matches 1.. run function kitpvp:skill/alchemist/clear_splash
execute if entity @s[tag=kitpvp.hold_pa_prev] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/alchemist/fire
