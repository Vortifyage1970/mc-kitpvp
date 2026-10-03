# ===== 选择职业：幽灵（kit=5） =====
# 分类：经典（表）
# 简介：潜行无形的幽魂，只有一条命
# 触发：kit/info/ghost 的 [ 确认选择 ] 按钮；@s = 选职业的玩家
# 骨架与 kit/tank 一致：清场 → 写回 kit → 发装备 → 永久被动 → 命数 → 反馈

# 1. 清到干净初始状态（会清掉 kit，紧接着写回）
function kitpvp:util/clear_player

# 2. 登记职业
scoreboard players set @s kitpvp.kit 5
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

# 3. 装备
#    头盔：带保护 V 的玩家头颅
#    ⚠ 1.20.1 旧版 NBT：附魔走 Enchantments:[{id,lvl}]
#    ⚠ 玩家头颅放在 armor.head 槽位时，其附魔（保护 V）会正常生效
item replace entity @s armor.head with minecraft:player_head{Enchantments:[{id:"minecraft:protection",lvl:5}],Unbreakable:1b}

#    主手：锋利 I 的金斧
item replace entity @s weapon.mainhand with minecraft:golden_axe{Enchantments:[{id:"minecraft:sharpness",lvl:1}],Unbreakable:1b}

#    金胸甲放背包不自动装备（玩家自行决定要不要穿）
give @s minecraft:golden_chestplate{Unbreakable:1b} 1

#    食物
give @s minecraft:cooked_beef 15

# 4. 永久被动：隐身 I + 速度 I
function kitpvp:kit/ghost_passive

# 5. 命数：只有 1 条
scoreboard players set @s kitpvp.lives 1

# 6. 反馈
tellraw @s [{"text":"[职业] ","color":"aqua","bold":true},{"text":"已选择 ","color":"gray"},{"text":"幽灵","color":"light_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
