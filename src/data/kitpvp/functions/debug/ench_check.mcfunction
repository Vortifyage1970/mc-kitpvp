# 打印附魔师的进度与两条关键附魔等级
execute store result score #ench_chk1 kitpvp.game run data get entity @p Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute store result score #ench_chk2 kitpvp.game run data get entity @p Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}].lvl
tellraw @a [{"text":"[附魔师] 强化次数=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_roll"}},{"text":" 倒计时=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_timer"}},{"text":" 头盔保护=","color":"gray"},{"score":{"name":"#ench_chk1","objective":"kitpvp.game"}},{"text":" 剑锋利=","color":"gray"},{"score":{"name":"#ench_chk2","objective":"kitpvp.game"}}]
