# ===== 坦克：给盾 + 进入冷却 =====
# 调用：skill/tank_cast（玩家右键令牌，cd 归零时）
# @s = 坦克
#
# 冷却从"给盾一瞬间"开始：
#   set cd 600 是本函数的最后一步，从这里开始连续 30 秒
#   前 300 刻盾在身上（15 秒），后 300 刻纯冷却
#   cd 到 ..300 时由 tick 触发 skill/tank_expire 清盾
#   cd 到 0 时由 tick 触发兜底补发新令牌
#
# === 盾牌 NBT 说明 ===
#   1.20.1 盾牌最大耐久固定 336，没有"设置最大耐久"的 NBT 字段。
#   要实现设计文档的"耐久 80"，用 Damage 反推：
#       Damage = 336 - 80 = 256
#   KitShield:1b 是本职业盾的私有标记。
#   skill/tank_expire 依靠它定位并清理。
#   不要给这个盾加 Unbreakable——会破坏"耐久 80 能用完"的设计。

give @s minecraft:shield{KitShield:1b,Damage:256} 1

tag @s add kitpvp.shield_held

scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"举盾：获得 15 秒护盾","color":"gold"}
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.8 1.0