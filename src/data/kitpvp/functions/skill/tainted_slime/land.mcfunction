# 落地即清：摔落伤害在落地那一 tick 的实体阶段就按跳跃提升结算完了，命令跑在实体之前，
# 所以落地后的第一刻清掉不会少减伤，也留不下"落地还能白跳"的余味。
effect clear @s minecraft:jump_boost
# 真正的常驻来源另外补回：表史莱姆的无限跳跃提升 III（魂石的 III 由 tick 的缺效果补发维持）
execute if score @s kitpvp.kit matches 10 run function kitpvp:skill/slime/passive
