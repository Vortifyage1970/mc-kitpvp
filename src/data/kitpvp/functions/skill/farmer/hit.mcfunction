# player_hurt_entity 是全局触发器，任何职业打到任何生物都会响：职业与"用锄头打的"都在这里判
# （"用什么打的"塞不进 conditions，见 02 §十一）
advancement revoke @s only kitpvp:player/farmer_hit
execute if score @s kitpvp.kit matches 13 if entity @s[tag=kitpvp.selected] if data entity @s SelectedItem.tag.KitFarmerHoe run function kitpvp:skill/farmer/grow
