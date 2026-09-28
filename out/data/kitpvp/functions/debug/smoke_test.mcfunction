# ============================================================
# KitPvP 冒烟测试（不依赖任何业务函数）
# 用法：玩家在游戏内执行  /function kitpvp:debug/smoke_test
# 覆盖：计分板 / 标题 / 音效 / 粒子 / 效果 / damage / tag / team
#       storage / bossbar / clickEvent / hoverEvent / attribute / schedule
# 副作用：临时创建 kitpvp.smoketest 计分项、smoke_red 队伍、
#        kitpvp:smoke bossbar、kitpvp.smoke tag，3 秒后由 echo 全部清理
# 全部为 1.20.1 语法，无 return / 宏 / execute if items
# 若 kitpvp.smoketest 已存在，第一步会报 already exists，无害
# ============================================================

# --- 0. 准备 ---
scoreboard objectives add kitpvp.smoketest dummy '冒烟测试'
scoreboard objectives setdisplay sidebar kitpvp.smoketest
scoreboard players set #smoke.const kitpvp.smoketest 2
scoreboard players set @s kitpvp.smoketest 0
tag @s add kitpvp.smoke

# --- 1. 标题链 ---
title @s times 10 40 10
title @s subtitle '{"text":"副标题 OK","color":"gray"}'
title @s title '{"text":"[1/9] 标题链","color":"gold","bold":true}'

# --- 2. 音效 ---
playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.5

# --- 3. 粒子 ---
execute at @s run particle minecraft:end_rod ~ ~1 ~ 0.5 0.5 0.5 0.1 60 normal
execute at @s run particle minecraft:flame ~ ~1 ~ 0.3 0.3 0.3 0.02 30 normal

# --- 4. 效果 + damage 命令（抗性 V 保护，几乎不掉血）---
effect give @s minecraft:resistance 5 4 true
effect give @s minecraft:regeneration 5 4 true
damage @s 1 minecraft:generic

# --- 5. 计分板运算：期望 (42 + 8 - 10) * 2 = 80 ---
scoreboard players set @s kitpvp.smoketest 42
scoreboard players add @s kitpvp.smoketest 8
scoreboard players remove @s kitpvp.smoketest 10
scoreboard players operation @s kitpvp.smoketest *= #smoke.const kitpvp.smoketest
tellraw @s '[{"text":"[2/9] 计分板：","color":"gold"},{"text":"期望 80，实际 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.smoketest"},"color":"aqua"}]'

# --- 6. tag 查询 ---
execute if entity @s[tag=kitpvp.smoke] run tellraw @s '{"text":"[3/9] tag 查询 OK","color":"green"}'

# --- 7. team 查询 ---
team add smoke_red
team join smoke_red @s
team modify smoke_red color red
team modify smoke_red prefix '{"text":"[测试] ","color":"red"}'
execute if entity @s[team=smoke_red] run tellraw @s '{"text":"[4/9] team 查询 OK","color":"green"}'

# --- 8. storage 读写与 NBT 匹配 ---
data modify storage kitpvp:smoke test.value set value 42
data modify storage kitpvp:smoke test.name set value "smoke"
execute if data storage kitpvp:smoke test.value run tellraw @s '{"text":"[5/9] storage 路径读写 OK","color":"green"}'
execute if data storage kitpvp:smoke test{value:42} run tellraw @s '{"text":"[6/9] storage NBT 匹配 OK","color":"green"}'

# --- 9. bossbar ---
bossbar add kitpvp:smoke '{"text":"冒烟测试进度"}'
bossbar set kitpvp:smoke color blue
bossbar set kitpvp:smoke style notched_10
bossbar set kitpvp:smoke max 9
bossbar set kitpvp:smoke value 6
bossbar set kitpvp:smoke players @s

# --- 10. clickEvent / hoverEvent（1.20.1 小驼峰 + contents）---
tellraw @s '[{"text":"[7/9] 文本组件：","color":"gold"},{"text":"[点我重跑]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/smoke_test"},"hoverEvent":{"action":"show_text","contents":{"text":"点击重新执行冒烟测试","color":"gray"}}},{"text":"   "},{"text":"[点我复制]","color":"aqua","clickEvent":{"action":"copy_to_clipboard","value":"/function kitpvp:debug/smoke_test"},"hoverEvent":{"action":"show_text","contents":{"text":"把命令复制到剪贴板","color":"gray"}}}]'

# --- 11. 只读属性查询（函数内不回显，主要用于验证语法不报错）---
attribute @s minecraft:generic.max_health get
attribute @s minecraft:generic.armor get

# --- 12. schedule 排程，3 秒后由 echo 完成收尾 ---
schedule function kitpvp:debug/smoke_test_echo 3s replace
tellraw @s '{"text":"[8/9] schedule 已排程，3 秒后见回显","color":"green"}'
