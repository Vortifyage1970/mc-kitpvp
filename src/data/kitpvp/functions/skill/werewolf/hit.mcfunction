# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次
advancement revoke @s only kitpvp:player/werewolf_hit

# 触发器是全局的，其它职业也会拿到本 advancement，故用 kit 值筛掉。
# 再看主手是不是嗜血狼牙：空手或捡来的别的武器不给被动。
# 打什么都能回：advancement 不再限定实体类型（玩家 / 召唤物 / 怪物都算），
# 只靠下面的 20 刻（1.0 秒）内置冷却防连点——比武器攻速 1.4 略慢，正常挥砍不受影响
execute if score @s kitpvp.kit matches 18 if score @s kitpvp.werewolf_hit_cd matches ..0 if data entity @s SelectedItem.tag.KitWerewolfAxe run function kitpvp:skill/werewolf/bite
