# ===== 选择职业：坦克（kit=3） =====
# 分类：经典（表）
# 触发：职业列表 / 菜单的 [ 坦克 ] 按钮；@s = 选职业的玩家
# 骨架与 kit/warrior 一致：清场 → 写回 kit → 发装备 → 永久效果 → 命数 → 技能初发 → 反馈

# 1. 清到干净初始状态（会清掉 kit，紧接着写回）
function kitpvp:util/clear_player

# 2. 登记职业
scoreboard players set @s kitpvp.kit 3
tag @s add kitpvp.selected

# 3. 装备（全套钻石 + 木剑，全部不可破坏）
#    护甲 20 / 护甲韧性 8 由钻石装备自然提供，不要额外 set attribute，否则会翻倍
item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b}
item replace entity @s weapon.mainhand with minecraft:wooden_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 16

# 4. 永久效果：减速 I + 挖掘疲劳 I（infinite，死亡不清，会一直挂着）
effect give @s minecraft:slowness infinite 0 true
effect give @s minecraft:mining_fatigue infinite 0 true

# 5. 命数
scoreboard players set @s kitpvp.lives 3

# 6. 技能初发：立刻发一面盾并进入 30 秒冷却，不依赖下一 tick 的自动分发
function kitpvp:skill/tank

# 7. 反馈
tellraw @s [{"text":"[职业] ","color":"aqua","bold":true},{"text":"已选择 ","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
