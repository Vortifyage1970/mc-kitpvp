# 地球·73 低空飞行器：一只普通蝙蝠吊着骷髅弓箭手，在召唤点就地出生；骷髅死则蝙蝠同死
# 和 69 号飞行器同一套骨架（分两帧召 + UUID 重试），只是"吊车"从幻翼换成普通蝙蝠，出生就在召唤者脚边
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
# ★ kill 只是标记：蝙蝠要播完死亡动画才真的消失，这期间它的 UUID 还占着，再 summon 同一个 UUID 会被静默丢掉。
#   所以这里只负责清场 + 留一个 marker 记住位置，真正的召唤与重试都在下一刻的 earth_lowflyer_a（最多试 3 秒）
kill @e[tag=kitpvp.earth_lowflyer_carrier]
kill @e[tag=kitpvp.earth_lowflyer_body]
kill @e[tag=kitpvp.lf_anchor]
# ★★ 队槽必须在这一刻记下来：蝙蝠要等下一帧才召，那时 summon 主流程里的 link 早就跑完了，
#    蝙蝠和骷髅身上永远不会自动有 earth_owner 和队伍 —— 没队伍，原版骷髅 AI 就会照着召唤者射箭。
#    （这就是"低空飞行器的骷髅还在射召唤者"的根因；69 号飞行器同样是延迟出生的，也一样要手动补）
# 没有队槽的玩家先补跑一次 link，和正常召唤同一套选槽逻辑
scoreboard players add @s kitpvp.etid 0
execute if score @s kitpvp.etid matches 0 run function kitpvp:skill/earth/link
scoreboard players operation #lf_owner kitpvp.game = @s kitpvp.etid
summon minecraft:marker ~ ~1 ~ {Tags:["kitpvp.lf_anchor"]}
scoreboard players set #lf_wait kitpvp.game 60
schedule function kitpvp:summon/earth_lowflyer_a 1t replace
