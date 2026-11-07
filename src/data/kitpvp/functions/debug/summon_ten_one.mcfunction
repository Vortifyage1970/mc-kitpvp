# 以最近的玩家为召唤者，随机召一只生灵并认归属（debug 十连用，不要塞进正式流程）
# 必须在 random 的同一个坐标上下文里紧接着跑 link，否则这只拿不到 earth_owner，会回头打召唤者
function kitpvp:skill/earth/random
function kitpvp:skill/earth/link
