# ===== 技能分发层 =====
# 调用方：tick.mcfunction
# 入口条件由 tick 过滤：kitpvp.kit >= 1 且 kitpvp.alive = 1 且 kitpvp.cd <= 0
# 也就是说，进入本函数时"应该结算技能"这个前提已经成立。
#
# 本函数只做一件事：按 kitpvp.kit 的值，转交到对应职业的技能函数。
# 新增职业时，只在下方追加一行，不要动 tick.mcfunction。
#
# ⚠ 强制约定（每个职业技能函数必须遵守）：
#   1) 自动技能函数末尾必须自己设冷却：
#        scoreboard players set @s kitpvp.cd <刻数>
#      漏写会导致 cd 一直停在 0，tick 每刻重复调用，技能无限触发。
#   2) 条件未满足时（例如战士背包里已有金苹果、上限已满），
#      不要设长冷却，set cd 0（或干脆不动）即可，让下一刻重试。
#      战士用的就是这个模式：吃到金苹果后下一刻立刻补发。
#   3) 主动技能不进本函数。主动技能靠"检测玩家操作"接：
#      坦克的举盾 → 统计 objective kitpvp.tank_used（铁傀儡刷怪蛋被使用）
#                 → tick.mcfunction 检测 used > last
#                 → skill/tank_cast → skill/tank_fire
#      新增主动技能时，按同样模式：一个统计 objective + 一个 xxx_cast 入口。
#
# kit 编号对照（与 util/give_kit.mcfunction 保持一致）：
#   1 战士   2 弓箭手   3 坦克   4 刺客
#   后续每 1 个职业顺延 1 号

# kit = 1 战士 · 补给（自动）
execute if score @s kitpvp.kit matches 1 run function kitpvp:skill/warrior

# kit = 2 弓箭手 · 换弹（触发器驱动，见 advancement archer_pickup）
# execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer

# kit = 3 坦克 · 举盾（主动技能，由统计 objective 驱动，不进 dispatch）
# 链路：minecraft.used:minecraft.iron_golem_spawn_egg > kitpvp.tank_last
#       → skill/tank_cast → skill/tank_fire

# kit = 4 刺客 · 隐匿（主动技能，由统计 objective 驱动，不进 dispatch）
# 链路：minecraft.used:minecraft.enderman_spawn_egg > kitpvp.assassin_last
#       → skill/assassin_cast → skill/assassin_fire
 