# 地鸣：聊天栏两行 + 音效 + 召唤巨人（一次性道具，用掉就没了）
scoreboard players operation @s kitpvp.mars_domain_last = @s kitpvp.mars_domain_used

tellraw @a [{"text":"━━━━━━━━ ","color":"dark_red","bold":true},{"text":"领域展开","color":"gold","bold":true},{"text":" ━━━━━━━━","color":"dark_red","bold":true}]
tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"地 鸣","color":"dark_red","bold":true},{"text":" ❖","color":"gold","bold":true}]

playsound minecraft:entity.warden.roar master @a ~ ~ ~ 1 0.7
execute as @a at @s run playsound minecraft:entity.warden.sonic_boom master @s ~ ~ ~ 0.6 1.1
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.9 0.6
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 1 0.5
particle minecraft:dust 0.6 0.05 0.05 3 ~ ~1 ~ 3 2 3 0.2 200 normal

# 巨人从施法者脚下 +8 落地（原来写 @r 随机玩家：多人会生在别人头上，没人可选时干脆不生）
execute at @s run function kitpvp:skill/mars/giant_spawn

# ⚠ 先清载体再碰音乐：万一存档没装 rumbling 歌包、调用外部函数出错中止，
#   这几行清不掉就会留下一只到处咬人的恼鬼（2026-11-15 实机就是这个现象）
execute at @s run kill @e[tag=kitpvp.mars_token,distance=..32]
execute at @s run kill @e[name="地鸣",distance=..32]
execute at @s run kill @e[type=minecraft:vex,distance=..8,tag=!kitpvp.displayitem]

scoreboard players set #mars_music kitpvp.game 0
scoreboard players set #mars_active kitpvp.game 1
schedule function kitpvp:skill/mars/song_end 1810t replace
function kitpvp:skill/mars/music_on
