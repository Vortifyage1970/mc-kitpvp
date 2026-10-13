# 结算入口：锁状态 → 宣布胜者（或平局/管理员终止）→ 10 秒后 reset。
# ..0 与 2.. 两个分支只供手动调用 end 时使用；自动路径恒为 matches 1。
scoreboard players set #state kitpvp.game 2

execute if score #survivors kitpvp.game matches 1 run title @a times 10 60 20
execute if score #survivors kitpvp.game matches 1 run title @a title {"text":"游戏结束","color":"gold","bold":true}
execute if score #survivors kitpvp.game matches 1 run title @a subtitle [{"text":"胜者：","color":"yellow"},{"selector":"@a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator]","color":"white","bold":true}]
execute if score #survivors kitpvp.game matches 1 run tellraw @a [{"text":"[胜利]","color":"gold","bold":true},{"selector":"@a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator]","color":"yellow"},{"text":" 赢了！","color":"yellow"}]
execute if score #survivors kitpvp.game matches 1 as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1

execute if score #survivors kitpvp.game matches ..0 run tellraw @a [{"text":"[平局]","color":"gray","bold":true},{"text":"本局无幸存者","color":"gray"}]
execute if score #survivors kitpvp.game matches 2.. run tellraw @a [{"text":"[结束]","color":"red","bold":true},{"text":"本局被管理员终止","color":"gray"}]

# 结算期封锁：10 秒内给全体抗性 V（100% 减伤），避免结算期间还有人被打死
effect give @a minecraft:resistance 10 4 true

# 200 刻 = 10 秒；replace 保证重复调用不叠定时器
schedule function kitpvp:game/reset 200t replace
