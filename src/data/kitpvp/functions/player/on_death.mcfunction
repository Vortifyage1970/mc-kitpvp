# ===== 死亡入口 =====

# 不再使用advancement

# --- 大厅死亡不计 ---
# 判据：tag=kitpvp.in_lobby（由 load 默认加、lobby/enter 加、lobby/exit 删）
# 大厅死亡：不计数、不扣命、不做重生处理、不淘汰

# 死亡计数
execute unless entity @s[tag=kitpvp.in_lobby] run scoreboard players add @s kitpvp.deaths 1

# 打上"待重生处理"的标记，交给根 tick 在重生之后消费
execute unless entity @s[tag=kitpvp.in_lobby] run tag @s add kitpvp.respawn_pending

# 命数 -1（除非该职业死亡不计）
execute unless entity @s[tag=kitpvp.in_lobby] unless entity @s[tag=kitpvp.death_immune] run scoreboard players remove @s kitpvp.lives 1

# 命数归 0 → 淘汰（alive=1 守卫防止旁观者被 /kill 时重复淘汰）
execute unless entity @s[tag=kitpvp.in_lobby] if score @s kitpvp.lives matches ..0 if score @s kitpvp.alive matches 1 run function kitpvp:player/eliminate