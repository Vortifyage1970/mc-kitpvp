# 地球·39 动员家：头戴品红色带釉陶瓦、手持附魔胡萝卜钓竿；只要它活着，每 15 秒逼全场点一次"准备"
# 计时挂在 earth_cd_a 上（400 刻 = 20 秒），归零时 tick 调 mobilizer_prompt 发提示并排 5 秒后的结算
# 死亡判定与木星同一套：脚下埋一枚隐形 marker 当守卫，本体没了就播红色的"结束准备"
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_mobilizer"],CustomName:'{"text":"动员家","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}},{}],ArmorItems:[{},{},{},{id:"minecraft:magenta_glazed_terracotta",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_mobilizer] kitpvp.earth_cd_a 400
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_mobilizer_guard"]}
# 出场：一声召集号，隔着半张图都听得见
playsound minecraft:event.raid.horn master @a[distance=..48] ~ ~ ~ 1.0 0.9
