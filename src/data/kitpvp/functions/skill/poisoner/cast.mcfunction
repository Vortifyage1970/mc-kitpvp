# 首行无条件推进快照；投掷入口的条件里不要加 hold 判断（见 05 §12）
scoreboard players operation @s kitpvp.poisoner_last = @s kitpvp.poisoner_used

title @s actionbar {"text":"毒雾已投出","color":"dark_green"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0

# ..0 守卫：计时中再投不把补货越推越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 300
