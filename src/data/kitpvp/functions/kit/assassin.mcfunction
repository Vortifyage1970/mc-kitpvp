# ===== 选择职业：刺客（kit=4） =====
# 分类：经典（表）
# 触发：职业列表 / 菜单的 [ 刺客 ] 按钮；@s = 选职业的玩家
# 骨架与 kit/tank 一致：清场 → 写回 kit → 发装备 → 永久效果 → 命数 → 技能初发 → 反馈

# 1. 清到干净初始状态（会清掉 kit，紧接着写回）
function kitpvp:util/clear_player

# 2. 登记职业
scoreboard players set @s kitpvp.kit 4
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

# 3. 装备（黑色皮革四件套 + 锋利 I 钻石剑，全部不可破坏）
#    黑色 = 0x1908001 = 1908001
#    护甲 7 由皮革自然提供（1 + 3 + 2 + 1），不要额外 set attribute
item replace entity @s armor.head with minecraft:leather_helmet{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:1908001},Unbreakable:1b}
item replace entity @s armor.feet with minecraft:leather_boots{display:{color:1908001},Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:diamond_sword{Enchantments:[{id:"minecraft:sharpness",lvl:1}],Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

# 4. 永久效果：速度 I（死亡会清空药水效果，重生由 after_death 重新挂）
function kitpvp:kit/assassin_passive

# 5. 命数
scoreboard players set @s kitpvp.lives 3

# 6. 技能初发：立刻发一个"隐匿令牌"
function kitpvp:skill/assassin_give_item

# 7. 反馈
tellraw @s [{"text":"[职业] ","color":"aqua","bold":true},{"text":"已选择 ","color":"gray"},{"text":"刺客","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
