# ===== 魂石·战士：力量 II，持续 20 秒 =====
tag @s add kitpvp.soul_given

# amplifier 1 = 力量 II；20 秒后由原版计时器自然消失
effect give @s minecraft:strength 20 1 true

title @s actionbar {"text":"魂石·战意：力量 II（20 秒）","color":"red"}
playsound minecraft:entity.player.attack.strong master @s ~ ~ ~ 0.8 1.2
