# ===== 战士技能：补给 =====
# 自动触发，无需右键
# 效果：每 40 秒（800 刻）获得 1 个金苹果，同时最多持有 1 个
# 调用方：tick.mcfunction
#   条件 kitpvp.kit=1 且 kitpvp.alive=1 且 kitpvp.cd <= 0
#
# 为什么需要 kitpvp.skill_ready 中转：
#   give 执行后背包立刻变化，若之后再写 execute unless data 判断会失败。
#   所以先判定"该不该发"并打 tag，再按 tag 执行，避免求值顺序陷阱。

# 清掉上一刻可能残留的中转 tag
tag @s remove kitpvp.skill_ready

# 背包里没有金苹果 → 标记为可发放
# 已有金苹果 → 不打标记，cd 停在 0，等玩家吃掉/丢掉后下一刻立刻补发
execute unless data entity @s Inventory[{id:"minecraft:golden_apple"}] run tag @s add kitpvp.skill_ready

# 发放 + 进入 40 秒冷却
execute if entity @s[tag=kitpvp.skill_ready] run give @s minecraft:golden_apple 1
execute if entity @s[tag=kitpvp.skill_ready] run scoreboard players set @s kitpvp.cd 800

# 反馈
execute if entity @s[tag=kitpvp.skill_ready] run title @s actionbar {"text":"补给：获得 1 个金苹果","color":"gold"}
execute if entity @s[tag=kitpvp.skill_ready] run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4

# 收尾
tag @s remove kitpvp.skill_ready
