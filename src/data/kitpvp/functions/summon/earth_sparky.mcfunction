# 地球·54 电磁炮（Sparky）：8 秒充能（160 刻）、放电一次 14 点魔法伤害（magic 无视护甲）
# 恢复 AI：它会自己追人、也会挥爪（近战伤害已压成 0，只靠放电输出），挂着缓慢 V ⇒ 移动速度只有 25%
# 50 血的上一版太薄，这版按原版 100 的三分之二给 66.67 血：能被集火点掉，但不至于一秒没
# 缓慢 V 是常驻的（infinite）；它靠 AI 自己走，不再用 tp 推（tp 层已退役，见 tick 注释）
# 劫掠兽不渲染护甲，所以没有 ArmorItems；外观靠金色名字 + 充能时的电弧与升调滴声
summon minecraft:ravager ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_sparky"],CustomName:'{"text":"电磁炮","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:66.67f,Attributes:[{Name:"minecraft:generic.max_health",Base:66.67},{Name:"minecraft:generic.attack_damage",Base:0.0}]}
# 双保险把近战压成 0：① 属性 attack_damage 基值 0；② 虚弱 X（每级 -4 点，共 -40）—— 劫掠兽的挥爪如果走属性伤害，两条里任一条都够
# 缓慢 V：每级 -15%，V 级只剩 25% 移动速度（劫掠兽基础 0.3 ⇒ 0.075，约玩家走路的 3/4、3 格/秒上下）
effect give @e[tag=kitpvp.earth_sparky] minecraft:slowness infinite 4 true
effect give @e[tag=kitpvp.earth_sparky] minecraft:weakness infinite 9 true
# 初值必须埋：scores={..0} 的选择器在"分数不存在"时压根不匹配，充能与滴声都会一声不吭地失效
scoreboard players set @e[tag=kitpvp.earth_sparky] kitpvp.sparky_charge 0
scoreboard players set @e[tag=kitpvp.earth_sparky] kitpvp.sparky_beep 20
