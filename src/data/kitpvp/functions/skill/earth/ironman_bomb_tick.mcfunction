# @s = 一颗小炸弹（伪装苦力怕，ExplosionRadius:0 ⇒ 原版自己不会炸人也不会炸地形）
# 40 刻（2 秒）后由这里结算：特效 + 音效 + 范围伤害，然后清掉
scoreboard players remove @s kitpvp.im_bomb_t 1
execute if score @s kitpvp.im_bomb_t matches ..0 at @s run particle minecraft:explosion_emitter ~ ~0.3 ~ 0 0 0 0 1
execute if score @s kitpvp.im_bomb_t matches ..0 at @s run particle minecraft:flame ~ ~0.3 ~ 0.6 0.4 0.6 0.05 25
execute if score @s kitpvp.im_bomb_t matches ..0 at @s run playsound minecraft:entity.generic.explode hostile @a[distance=..24] ~ ~ ~ 1 1.2
# 伤害只结算给玩家（铁人自己站在炸弹上，绝不受伤）：3.5 格内 5 点
execute if score @s kitpvp.im_bomb_t matches ..0 at @s if entity @e[tag=kitpvp.earth_ironman,limit=1,sort=nearest] as @a[distance=..3.5,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run damage @s 5 minecraft:explosion by @e[tag=kitpvp.earth_ironman,limit=1,sort=nearest]
execute if score @s kitpvp.im_bomb_t matches ..0 at @s unless entity @e[tag=kitpvp.earth_ironman,limit=1,sort=nearest] as @a[distance=..3.5,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run damage @s 5 minecraft:explosion
execute if score @s kitpvp.im_bomb_t matches ..0 run kill @s
