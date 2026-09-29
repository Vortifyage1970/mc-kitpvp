# ===== 生成调试怪物（子菜单） =====
# 所有生成出来的实体都带 tag kitpvp.debug_mob，便于一键清理

tellraw @s [{"text":"═══════ 生成怪物 ═══════","color":"red","bold":true}]
tellraw @s [{"text":"[ 假人靶子（无 AI 僵尸） ]","color":"gray","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_dummy"},"hoverEvent":{"action":"show_text","contents":[{"text":"静音、无 AI、不动但可打","color":"gray"}]}}]
tellraw @s [{"text":"[ 攻击僵尸（铁剑） ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_zombie"},"hoverEvent":{"action":"show_text","contents":[{"text":"持铁剑的僵尸","color":"gray"}]}}]
tellraw @s [{"text":"[ 攻击骷髅（弓） ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_skeleton"},"hoverEvent":{"action":"show_text","contents":[{"text":"持弓的骷髅","color":"gray"}]}}]
tellraw @s [{"text":"[ 苦力怕 ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_creeper"},"hoverEvent":{"action":"show_text","contents":[{"text":"受 mobGriefing=false 保护","color":"gray"}]}}]
tellraw @s [{"text":"[ 清空调试怪物 ]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/kill_mobs"},"hoverEvent":{"action":"show_text","contents":[{"text":"kill 所有 kitpvp.debug_mob","color":"gray"}]}}]
tellraw @s [{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到调试菜单","color":"gray"}]}}]
