# 地球·73 低空飞行器：一只普通蝙蝠吊着骷髅弓箭手，在召唤点就地出生；骷髅死则蝙蝠同死
# 和 69 号飞行器同一套骨架（分两帧召 + UUID 重试），只是"吊车"从幻翼换成普通蝙蝠，出生就在召唤者脚边
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
# ★ kill 只是标记：蝙蝠要播完死亡动画才真的消失，这期间它的 UUID 还占着，再 summon 同一个 UUID 会被静默丢掉。
#   所以这里只负责清场 + 留一个 marker 记住位置，真正的召唤与重试都在下一刻的 earth_lowflyer_a（最多试 3 秒）
kill @e[tag=kitpvp.earth_lowflyer_carrier]
kill @e[tag=kitpvp.earth_lowflyer_body]
kill @e[tag=kitpvp.lf_anchor]
# ★★ 队伍必须在召唤这一刻就确定：random 是在 summon.mcfunction 里的 link 之前跑的，
#    而 link 只给"当刻已经存在"的生灵发队伍；蝙蝠要等下一帧才出生，等它出现时 link 早就跑完了。
#    结果就是蝙蝠和骷髅一辈子没有队伍 —— 原版骷髅 AI 不看别的，只看队友，没队友就把召唤者也当敌人。
#    所以这里先保证召唤者自己有队槽（没有就补跑一次 link），再用 tag 把"这一对的召唤者"记到下一帧。
execute unless score @s kitpvp.etid matches 1.. run function kitpvp:skill/earth/link
tag @a remove kitpvp.lf_owner_tmp
tag @s add kitpvp.lf_owner_tmp
summon minecraft:marker ~ ~1 ~ {Tags:["kitpvp.lf_anchor"]}
scoreboard players set #lf_wait kitpvp.game 60
schedule function kitpvp:summon/earth_lowflyer_a 1t replace
