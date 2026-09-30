# ===== 坦克技能：举盾 =====
# 调用方：
#   1) tick → skill/dispatch（cd <= 0 时）
#   2) kit/tank（选完职业立刻发第一个盾）
#
# 进入条件：kit=3 且 alive=1 且 cd <= 0
#
# === 状态机设计 ===
# 只用一个 kitpvp.cd 记录"盾期 + 冷却"两段：
#   cd 600 → 301   盾在身上（15 秒有效期）
#   cd 300         由 tick 触发 skill/tank_expire 清盾、摘 tag
#   cd 299 → 1     纯冷却（再等 15 秒）
#   cd 0           本函数再次被 dispatch 调用 → 发新盾
#
# 为什么这样设计：
#   1.20.1 的 schedule 不能带参数，无法用 schedule 给单个玩家做"15 秒后清盾"。
#   用同一个 cd 分两段处理，天然给每个玩家独立计时，也不会互相污染。
#
# === 盾牌 NBT 说明 ===
#   1.20.1 盾牌最大耐久固定 336，没有"设置最大耐久"的 NBT 字段。
#   要实现设计文档的"耐久 80"，只能反推 Damage：
#       Damage = 336 - 80 = 256
#   因此物品 NBT 写成 Damage:256。
#   KitShield:1b 是本职业盾的私有标记，skill/tank_expire 依靠它定位。
#   不要给这个盾加 Unbreakable——会破坏"耐久 80 能用完"的设计。
#
# ⚠ 与武器槽的关系：
#   盾发到副手（weapon.offhand）。坦克不占副手做其它用途。
#   若地图上捡了东西到副手再点确认，item replace 会覆盖那一格——这是设计取舍。

# 1. 发盾（副手，带 KitShield 标记，剩余耐久 80）
item replace entity @s weapon.offhand with minecraft:shield{KitShield:1b,Damage:256} 1

# 2. 打"持盾中"标记，tick 靠它识别到期事件
tag @s add kitpvp.shield_held

# 3. 进入 30 秒冷却（600 刻）
#    前 300 刻盾在身上，后 300 刻空转
scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"举盾：获得 15 秒护盾","color":"gold"}
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.8 1.0
