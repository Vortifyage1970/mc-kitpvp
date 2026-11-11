# COSER 发物料：由 advancement kitpvp:player/coser_give 触发（@s = 被这只 COSER 打中的那名玩家）
# 触发器是 entity_hurt_player + damage.source_entity.nbt 匹配 Tags:["kitpvp.earth_coser"]
#   —— 只有真被它打中的那个人会进这里；旧版"挨打那一帧 + 32 格内有 COSER"会被摔伤、别人砍你、别的怪打你触发
# 首行必须 revoke：advancement 的 rewards 只在"完成"那一刻发放一次
advancement revoke @s only kitpvp:player/coser_give
# 3 秒冷却：分数在 1.. 之间就跳过（分不存在时 matches 1.. 不成立，等于放行）
execute unless score @s kitpvp.coser_cd matches 1.. run function kitpvp:skill/earth/coser_paper