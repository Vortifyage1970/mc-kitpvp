# 压力板 → 职业介绍分流：x/y/z 是压力板方块自身的坐标，dx=dy=dz=1 恰好覆盖该方块。
# 新增一块职业板时按同格式追加一行；坐标重复会同时弹出多张卡片。
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
