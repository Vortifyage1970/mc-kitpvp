# 判据不绑"刚放过技能"：丢地上 / 被偷 / 背包满掉地上都要能自愈，所以手上一颗、地上也没有才算真丢了
# 多发一颗换不到额外一发（施法看 cd2），见 04 §四
execute unless data entity @s Inventory[{tag:{KitSunspotEgg:1b}}] unless entity @e[type=minecraft:item,nbt={Item:{tag:{KitSunspotEgg:1b}}},distance=..16] run function kitpvp:skill/sun/refill_give_spot
