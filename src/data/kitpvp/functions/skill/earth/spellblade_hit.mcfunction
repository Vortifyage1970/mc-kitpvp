# 术战士打中人的结算（@s = 挨打的那个玩家，由 advancement kitpvp:player/spellblade_hit 触发）
# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次，不 revoke 就只生效一次
advancement revoke @s only kitpvp:player/spellblade_hit

# 每挨一刀就在脚下铺一格细雪，10 秒（200 刻）后由 tick 收回；只在脚下是空气时铺，不覆盖地图方块
# 细雪冻伤在 140 刻（7 秒）开始、之后每 40 刻一下：被埋满 10 秒的人会吃到 1~2 下冰冻伤害
scoreboard players set #snow_time kitpvp.game 200
execute at @s if block ~ ~ ~ #minecraft:air run function kitpvp:skill/earth/snow_place
