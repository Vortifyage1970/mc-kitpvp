# ===== 坦克蛋分派：举盾令牌 / 坦克魂石 共用 iron_golem_spawn_egg =====
# @s = 玩家；由 tick 在 tank_used 变化时调用。
# 铁律：首行快照推进。原 tank_cast 首行也会推进一次，值相同，冗余无害。
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

# 用生成的生物 CustomName 区分按下的是哪颗蛋：
#   举盾令牌 → 只有坦克本人且 cd=0 时生效（走原 tank_cast）
#   坦克魂石 → 任何已选职业玩家都生效，无 cd（走 soul/use_tank）
# @e[...,distance=..8] 覆盖刷怪蛋最大右键射程（约 4.5 格）+ 生物轻微漂移

# 举盾令牌分支
execute if score @s kitpvp.kit matches 3 at @s if entity @e[type=iron_golem,name="举盾令牌",distance=..8] run function kitpvp:skill/tank_cast

# 坦克魂石分支
execute at @s if entity @e[type=iron_golem,name="坦克魂石",distance=..8] run function kitpvp:skill/soul/use_tank
