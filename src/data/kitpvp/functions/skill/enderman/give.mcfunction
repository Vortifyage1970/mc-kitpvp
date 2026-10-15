give @s minecraft:ender_pearl{KitEnderPearl:1b} 1

# 补货节流 500 刻（25 秒）；投出珍珠不碰 cd（见 03 §2.13）
scoreboard players set @s kitpvp.cd 500

title @s actionbar {"text":"末影之珠 +1","color":"dark_purple"}
playsound minecraft:entity.enderman.ambient master @s ~ ~ ~ 0.8 1.4
