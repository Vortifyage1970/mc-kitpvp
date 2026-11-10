# 压力板 → 职业介绍分流：x/y/z 是压力板方块自身的坐标，dx=dy=dz=1 恰好覆盖该方块。
# 本文件由 tools/gen_lobby.py 生成：坐标表来自生成器的 ROWS，别再手抄（会和压力板漂移）。
tag @s add kitpvp.on_pad

execute if entity @s[x=-226,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/warrior
execute if entity @s[x=-230,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/archer
execute if entity @s[x=-234,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tank
execute if entity @s[x=-238,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/assassin
execute if entity @s[x=-242,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/arsonist
execute if entity @s[x=-246,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/ghost
execute if entity @s[x=-250,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/pirate
execute if entity @s[x=-254,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/enderman
execute if entity @s[x=-258,y=71,z=98,dx=1,dy=1,dz=1] run function kitpvp:kit/info/slime
execute if entity @s[x=-226,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/alchemist
execute if entity @s[x=-230,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tamer
execute if entity @s[x=-234,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/fisher
execute if entity @s[x=-238,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/zombie
execute if entity @s[x=-242,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/bomber
execute if entity @s[x=-246,y=71,z=90,dx=1,dy=1,dz=1] run function kitpvp:kit/info/werewolf
execute if entity @s[x=227,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_warrior
execute if entity @s[x=231,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_archer
execute if entity @s[x=235,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_tank
execute if entity @s[x=239,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_arsonist
execute if entity @s[x=243,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_ghost
execute if entity @s[x=247,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_slime
execute if entity @s[x=251,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_tamer
execute if entity @s[x=255,y=68,z=93,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_fisher
execute if entity @s[x=227,y=68,z=101,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tainted_bomber
