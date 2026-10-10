# ===== 职业：幽灵（kit = 6）=====
# 分类：经典（表）
# 定位：仅 1 条命的高机动潜伏者
# 装备：锋利 I 金斧；保护 V 史蒂夫头颅、金胸甲；16 牛排
# 被动：永久 速度 I + 隐身 I
#       受到伤害时获得 1 秒发光（由 advancement kitpvp:player/ghost_hurt 触发）
# 调用方：kit/info/ghost 的 [确认选择] 按钮、util/give_kit

function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 6
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 1

# --- 装备 ---
# 金斧：锋利 I；金胸甲；玩家头颅（Steve）带保护 V
give @s minecraft:golden_axe{Enchantments:[{id:"minecraft:sharpness",lvl:1}],Unbreakable:1b} 1
give @s minecraft:player_head{SkullOwner:"Ghost",Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
give @s minecraft:golden_chestplate{Unbreakable:1b} 1
give @s minecraft:cooked_beef 24

# --- 永久被动（速度 I + 隐身 I）---
function kitpvp:kit/ghost_passive

# --- 标记 ---
tag @s add kitpvp.selected
