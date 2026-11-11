# 地球·42 双星：两只 8 血的僵尸/骷髅一起出场 —— A 头顶诡异菌核、B 头顶绯红菌核
# 死一个不算死：1.5 秒内另一只还活着，死的这只会被"拉回来"；两只在 1.5 秒内都死了才真的消失
# 判定靠各自脚下的隐形 marker（尸体一瞬就没了，读不到 Health=0），逻辑在 skill/earth/twinstar_died_a / _b；复活窗口 30 刻 = 1.5 秒
function kitpvp:summon/earth_twinstar_a
function kitpvp:summon/earth_twinstar_b
