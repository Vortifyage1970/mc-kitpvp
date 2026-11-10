# 临时探针：任何"右键方块"都报一声，用来把问题劈成两半
#   响了 → item_used_on_block 触发器本身没问题，问题在 lobby_launch 的 blocks / position 条件
#   不响 → 这套环境里触发器就不响应（那就得改走位置检测，见下面的注释）
# 查完删掉这个文件和 advancements/player/launch_probe.json 即可
advancement revoke @s only kitpvp:player/launch_probe
tellraw @s [{"text":"[探测] ","color":"light_purple","bold":true},{"text":"item_used_on_block 响了 —— 触发器没问题，问题在 lobby_launch 的条件里","color":"white"}]
