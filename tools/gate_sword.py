import io, os
FN = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "src", "data", "kitpvp", "functions")
p = os.path.join(FN, "skill", "enchanter", "roll_sword.mcfunction")
with io.open(p, "r", encoding="utf-8") as f:
    t = f.read()
old = "execute if score #ench_r kitpvp.game matches"
new = "execute if data entity @s SelectedItem{id:\"minecraft:golden_sword\"} if score #ench_r kitpvp.game matches"
t = t.replace(old, new)
with io.open(p, "w", encoding="utf-8", newline="\n") as f:
    f.write(t)
print(t.count("SelectedItem"))
