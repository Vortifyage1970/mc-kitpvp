# 给盾并进冷却：cd=600（30 秒），前 300 刻持盾；cd 到 ..300 时 tick 触发 tank_expire 清盾。
# 1.20.1 盾最大耐久固定 336，无 MaxDurability 字段："耐久 80" 用 Damage=336-80=256 反推。
# 不要给这个盾加 Unbreakable——会破坏"耐久 80 用完即碎"的设计。
give @s minecraft:shield{KitShield:1b,Damage:256} 1

tag @s add kitpvp.shield_held

scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"举盾：获得 15 秒护盾","color":"gold"}
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.8 1.0
