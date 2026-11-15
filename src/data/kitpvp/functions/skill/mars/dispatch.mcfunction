# 地鸣入口（幽灵魂石 / 里·驯兽师怨灵仆从都用 vex_spawn_egg，共用同一个 used 统计）：
# 首行**无条件**推进快照，再按**载体的 tag** 分流 —— 只有地鸣蛋刷出的那只（带 mars_token）才放地鸣。
# 用 tag 而不是名字：名字是中文，跨控制台 / 编码容易失真；tag 是 ASCII 且蛋的 EntityTag 已经写好。
# 漏写首行会让"用了别人的恼鬼蛋"积压着，下次用地鸣时提前触发（见 04 §17.4）。
scoreboard players operation @s kitpvp.mars_domain_last = @s kitpvp.mars_domain_used

execute at @s if entity @e[type=minecraft:vex,tag=kitpvp.mars_token,distance=..8] run function kitpvp:skill/mars/domain_cast
