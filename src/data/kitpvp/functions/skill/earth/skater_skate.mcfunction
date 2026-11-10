# 滑冰者的滑行声：鞋底碾碎薄冰的沙沙声，每 2 秒一声（间隔靠 kitpvp.skater_snd 这个独立的分，不和铺雪的 earth_cd_a 抢）
# 两条叠着放：powder_snow.step 是"踩"的摩擦，powder_snow.break 是"碎"的一下，音高错开一点就不会糊成一团
playsound minecraft:block.powder_snow.step master @a[distance=..16] ~ ~ ~ 0.9 1.25
playsound minecraft:block.powder_snow.break master @a[distance=..16] ~ ~ ~ 0.7 1.45
scoreboard players set @s kitpvp.skater_snd 40
# 数着滑了几次：减到 0 就来一声寒带动物的叫（见 skater_call），然后重置成 2
scoreboard players remove @s kitpvp.skater_call 1
execute if score @s kitpvp.skater_call matches ..0 run function kitpvp:skill/earth/skater_call
