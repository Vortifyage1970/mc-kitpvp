# ===== 刺客蛋分派：隐匿令牌 / 刺客魂石 共用 enderman_spawn_egg =====
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

# 隐匿令牌分支（仅刺客本人，保留原 cd 判断）
execute if score @s kitpvp.kit matches 4 at @s if entity @e[type=enderman,name="隐匿令牌",distance=..8] run function kitpvp:skill/assassin_cast

# 刺客魂石分支（任何已选职业玩家）
execute at @s if entity @e[type=enderman,name="刺客魂石",distance=..8] run function kitpvp:skill/soul/use_assassin
