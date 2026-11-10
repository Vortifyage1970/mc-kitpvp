# 重生后处理（doImmediateRespawn=true，原版已放好 spawnpoint）
# 由 tick 在 Health 归位、即原版重生真正完成后才调用——死亡当刻挂效果会被重生清掉
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.assassin_hidden

# 出生点被水/方块占住时原版会把人丢到主大厅出生点，这里按锚点送回自己的出生点（见 04 §十一）
function kitpvp:player/spawn_anchor

# 舔狗跟着重生：重生是跨区块传送，当刻不拉一把，狗可能留在旧区块里再也追不上（见 04 §十四）
execute if score @s kitpvp.kit matches 67 at @s run function kitpvp:skill/venus/dog_follow

function kitpvp:player/invincible

# 蓄力火箭跳：死亡时可能停在半空，蓄力与"满蓄力音效已响过"都要复位（tag 留着，重生后照常蓄力）
scoreboard players set @s kitpvp.rocket_charge 0
tag @s remove kitpvp.rocket_full

# 死亡清空了药水效果，重生后重挂职业被动（新增被动职业在此追加一行）
execute if score @s kitpvp.kit matches 3 run function kitpvp:skill/tank/passive
execute if score @s kitpvp.kit matches 4 run function kitpvp:skill/assassin/passive
execute if score @s kitpvp.kit matches 6 run function kitpvp:skill/ghost/passive
execute if score @s kitpvp.kit matches 10 run function kitpvp:skill/slime/passive
execute if score @s kitpvp.kit matches 66 run function kitpvp:skill/mercury/passive
execute if score @s kitpvp.kit matches 25 run function kitpvp:skill/tainted_tank/passive
execute if score @s kitpvp.kit matches 28 run function kitpvp:skill/tainted_ghost/passive

# 僵尸：重生后把"多一条血条"补回来（上限 40 + 5 秒生命恢复 V 填满第二条）
execute if score @s kitpvp.kit matches 14 run function kitpvp:skill/zombie/passive

# 冥王星：隐身 / 抗性 V 重生后被清掉了，重挂；鹦鹉没了就在身边补一只
execute if score @s kitpvp.kit matches 76 run function kitpvp:skill/pluto/passive
execute if score @s kitpvp.kit matches 76 run function kitpvp:skill/pluto/respawn

# 药剂师的四条秘药是"每条命一套"：重生解锁并补满
execute if score @s kitpvp.kit matches 12 run function kitpvp:skill/alchemist/restock_elixir

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
