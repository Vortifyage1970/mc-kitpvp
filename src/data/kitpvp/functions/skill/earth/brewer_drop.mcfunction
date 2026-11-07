# 酿造台每 15 秒调一次：在脚边丢一瓶随机滞留药水，落地后留 1 秒、半径 3 格的云（brewer_break 统一结算）
# 0 力量 I / 1 速度 I / 2 瞬间伤害 I / 3 反胃 I / 4 抗性提升 I
# ⚠ 1.20.1 没有 /random 命令（1.20.2 才加），这里用 random/1in2 连掷 3 次拼 0..7 再对 5 取模
# 瓶子 PickupDelay 拉满、brw_life 每刻 +1：捡不走，卡在水里或半空也会在 30 刻后自己结算
scoreboard players set #brw kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #brw kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #brw kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #brw kitpvp.game 4
scoreboard players set #brw_mod kitpvp.game 5
scoreboard players operation #brw kitpvp.game %= #brw_mod kitpvp.game
execute if score #brw kitpvp.game matches 0 run summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:lingering_potion",Count:1b,tag:{CustomPotionColor:12625004,CustomPotionEffects:[{Id:5b,Amplifier:0b,Duration:300}],display:{Name:'{"text":"力量 I","color":"red"}'}}},PickupDelay:32767s,Tags:["kitpvp.brw_potion","kitpvp.brw_strength"]}
execute if score #brw kitpvp.game matches 1 run summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:lingering_potion",Count:1b,tag:{CustomPotionColor:8518,CustomPotionEffects:[{Id:1b,Amplifier:0b,Duration:300}],display:{Name:'{"text":"速度 I","color":"aqua"}'}}},PickupDelay:32767s,Tags:["kitpvp.brw_potion","kitpvp.brw_speed"]}
execute if score #brw kitpvp.game matches 2 run summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:lingering_potion",Count:1b,tag:{CustomPotionColor:4393481,CustomPotionEffects:[{Id:7b,Amplifier:0b,Duration:1}],display:{Name:'{"text":"瞬间伤害 I","color":"dark_purple"}'}}},PickupDelay:32767s,Tags:["kitpvp.brw_potion","kitpvp.brw_harm"]}
execute if score #brw kitpvp.game matches 3 run summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:lingering_potion",Count:1b,tag:{CustomPotionColor:5511764,CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:300}],display:{Name:'{"text":"反胃 I","color":"dark_green"}'}}},PickupDelay:32767s,Tags:["kitpvp.brw_potion","kitpvp.brw_nausea"]}
execute if score #brw kitpvp.game matches 4 run summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:lingering_potion",Count:1b,tag:{CustomPotionColor:10044730,CustomPotionEffects:[{Id:11b,Amplifier:0b,Duration:300}],display:{Name:'{"text":"抗性提升 I","color":"blue"}'}}},PickupDelay:32767s,Tags:["kitpvp.brw_potion","kitpvp.brw_resist"]}
scoreboard players set @e[tag=kitpvp.brw_potion] kitpvp.brw_life 0
playsound minecraft:block.brewing_stand.brew block @a ~ ~ ~ 0.6 0.9
# 15 秒 = 300 刻
scoreboard players set @s kitpvp.earth_cd_a 300
