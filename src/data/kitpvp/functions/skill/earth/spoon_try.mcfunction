# @s = 被勺子打中的玩家（advancement: player/spoon_hit 判定"伤害来源是带 kitpvp.earth_spoon 的骷髅"）
# 近战和箭都走这里，不再靠"站在勺子 1.5 格内"猜
advancement revoke @s only kitpvp:player/spoon_hit
function kitpvp:skill/earth/spoon_hit
