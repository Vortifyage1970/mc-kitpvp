# 绊索陷阱 被捡起（minecraft.picked_up 判据）：先推进快照，再判是不是别人放的（自己的就是回收）
scoreboard players operation @s kitpvp.trap_hook_pick_last = @s kitpvp.trap_hook_pick_used
function kitpvp:skill/zhanshishi/check_hook
