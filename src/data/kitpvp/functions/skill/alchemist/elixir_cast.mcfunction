# 每条命只有一瓶：喝下任何一瓶就清空其余并把锁挂到死亡（player/after_death 解锁并补满）
scoreboard players operation @s kitpvp.alchemist_drink_last = @s kitpvp.alchemist_drink_used

execute if entity @s[tag=kitpvp.hold_pa_drink_prev] if entity @s[tag=kitpvp.alchemist_elixir_used] run function kitpvp:skill/alchemist/elixir_deny
execute if entity @s[tag=kitpvp.hold_pa_drink_prev] unless entity @s[tag=kitpvp.alchemist_elixir_used] run function kitpvp:skill/alchemist/elixir_fire
