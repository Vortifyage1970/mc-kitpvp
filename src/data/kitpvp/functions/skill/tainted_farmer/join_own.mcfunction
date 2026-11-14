# @s = 刚召出的领袖 / 农民：按身上记的 tf_owner 归队，然后摘掉 _new
# 选择器比不了分数，只能六行逐槽比对（同 skill/tainted_archer/team_slot 的理由）
execute if score @s kitpvp.tf_owner matches 1 run team join farmer_1 @s
execute if score @s kitpvp.tf_owner matches 2 run team join farmer_2 @s
execute if score @s kitpvp.tf_owner matches 3 run team join farmer_3 @s
execute if score @s kitpvp.tf_owner matches 4 run team join farmer_4 @s
execute if score @s kitpvp.tf_owner matches 5 run team join farmer_5 @s
execute if score @s kitpvp.tf_owner matches 6 run team join farmer_6 @s
tag @s remove kitpvp.tf_new
