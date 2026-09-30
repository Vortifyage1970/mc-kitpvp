  execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run function kitpvp:skill/tank_cast
  
