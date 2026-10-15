# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次
advancement revoke @s only kitpvp:player/werewolf_kill

# 触发器是全局的，其它职业也会拿到本 advancement，故用 kit 值筛掉
execute if score @s kitpvp.kit matches 18 run function kitpvp:skill/werewolf/feed
