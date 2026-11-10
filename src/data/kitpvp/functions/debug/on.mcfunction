gamerule sendCommandFeedback true
scoreboard players set #debug kitpvp.game 1

say ===== debug 模式 已开启 =====
tellraw @a [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已开启：单人开局不会自动判胜；自动结算停用。","color":"white"}]
tellraw @a [{"text":"▶ solo_start","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/solo_start"},"hoverEvent":{"action":"show_text","contents":"单人开始一局（不传送）"}}]
tellraw @a [{"text":"▶ play","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/play"},"hoverEvent":{"action":"show_text","contents":"游玩模式（生存+参与游戏统计）"}}]
tellraw @a [{"text":"▶ build","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/build"},"hoverEvent":{"action":"show_text","contents":"建造模式（创造+退出游戏统计）"}}]
tellraw @a [{"text":"▶ status","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/status"},"hoverEvent":{"action":"show_text","contents":"打印自己的分数 / 全局状态"}}]
tellraw @a [{"text":"▶ music","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/music"},"hoverEvent":{"action":"show_text","contents":"点歌（雨爱 / 非人类 / 伊邪那岐）"}}]
tellraw @a [{"text":"▶ notch_mode","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/notch_mode"},"hoverEvent":{"action":"show_text","contents":"Notch 模式：饱和+生命恢复 X 无限（再点一次关闭）"}}]
tellraw @a [{"text":"▶ force_reset","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/force_reset"},"hoverEvent":{"action":"show_text","contents":"立刻重置回大厅（不等 10 秒倒计时）"}}]
tellraw @a [{"text":"▶ sudden_death","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:game/sudden_death_start"},"hoverEvent":{"action":"show_text","contents":"立刻进入突然死亡（魂石间隔按剩余命数：3 命 45 秒 / 2 命 35 秒 / 1 命 25 秒）"}}]
tellraw @a [{"text":"▶ soul_stone_give","color":"aqua","clickEvent":{"action":"run_command","value":"/execute as @a run function kitpvp:skill/soul/give"},"hoverEvent":{"action":"show_text","contents":"给所有存活玩家发魂石"}}]
tellraw @a [{"text":"▶ suicide","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/suicide"},"hoverEvent":{"action":"show_text","contents":"自杀一次（走真实死亡结算）"}}]
tellraw @a [{"text":"▶ off","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/off"},"hoverEvent":{"action":"show_text","contents":"关闭 debug 模式"}}]
