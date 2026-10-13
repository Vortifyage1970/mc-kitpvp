# 自动技能分派：tick 在 kitpvp.cd<=0 时调用。函数末尾必须自己 set kitpvp.cd，否则每刻重复触发。
# 主动技能与触发器驱动技能不进这里（见 05 §3 / §12）。新增自动技能在此追加一行。
# 其余职业无自动技能：2 弓箭手 / 3 坦克 / 4 刺客 / 6 幽灵 / 7 渔夫 / 9 海盗

# kit = 1 战士：技能已删除
# execute if score @s kitpvp.kit matches 1 run function kitpvp:skill/warrior

# kit = 5 纵火狂：燃烧瓶补给
execute if score @s kitpvp.kit matches 5 run function kitpvp:skill/arsonist

# kit = 8 末影人：末影之珠补货
execute if score @s kitpvp.kit matches 8 run function kitpvp:skill/enderman
