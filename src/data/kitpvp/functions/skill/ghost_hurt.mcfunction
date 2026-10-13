# 首行必须 revoke：advancement 只在"完成"那一刻发放 rewards，不 revoke 则下次受伤不再触发
advancement revoke @s only kitpvp:player/ghost_hurt

# 触发器是全局的，其它职业也会拿到本 advancement，故用 kit 值筛掉
execute if score @s kitpvp.kit matches 6 run effect give @s minecraft:glowing 1 0 true
