# 首行无条件推进快照：喷溅药水在本服还有纵火狂 / 药剂师两个来源（见 05 §12）
scoreboard players operation @s kitpvp.civil_last = @s kitpvp.civil_used

# 只有上一刻拿着自己的口水才进补货计时；..0 守卫保证连喷不把补货越推越远（03 §2.13）
execute if entity @s[tag=kitpvp.hold_cb_prev] if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 80
