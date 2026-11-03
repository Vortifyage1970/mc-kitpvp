# 豪宅：两块模板沿 z 拼（起点 6651 60 -46 / 6651 61 2），只回滚方块。
# 模板只含方块（导出时关掉「包含实体」）；画 / 盔甲架 / 船 / 矿车等装饰在这张图里手动摆好，
# 打了 invulnerable + kitpvp.displayitem，所以这里**不再按区域清实体**（见 04 §七.3）。
# 画不进模板的理由见 04 §七.5；想批量补 38 幅画，可以在末尾加一行
# function kitpvp:map/mansion/paintings（注意别和手摆的那批重复）。
# place template <template> [pos] [rotation] [mirror] [integrity] [seed]
place template kitpvp:mansion1 6651 60 -46
place template kitpvp:mansion2 6651 61 2
