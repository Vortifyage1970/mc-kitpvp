# 《神学大全》自检：手上是什么、有没有 KitBook、读书进度多少
execute as @p run tellraw @a [{"text":"[神学大全] 主手=","color":"gray"},{"nbt":"SelectedItem","entity":"@p"}]
execute as @p run tellraw @a [{"text":"[神学大全] 读书计时=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_book_t"}},{"text":" / 300","color":"dark_gray"}]
