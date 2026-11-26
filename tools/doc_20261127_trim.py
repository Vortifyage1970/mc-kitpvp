# -*- coding: utf-8 -*-
"""档案收尾：踢掉大蜜蜂 / 铁人，重排表格的「地球·」与「池号」。"""
import io, re

DOC = "ai-content/08-地球生灵档案.md"
with io.open(DOC, encoding="utf-8") as f:
    lines = f.read().split("\n")

DROP = ("大蜜蜂", "铁人")

# 1) 删掉 §2.22 铁人 整节（到下一个 ### 或 ## 为止）
out = []
i = 0
while i < len(lines):
    ln = lines[i]
    if ln.startswith("### 2.22 ") and "铁人" in ln:
        i += 1
        while i < len(lines) and not (lines[i].startswith("### ") or lines[i].startswith("## ")):
            i += 1
        continue
    out.append(ln)
    i += 1
lines = out

# 2) 删掉提到大蜜蜂的说明行与已知限制里的那条
lines = [ln for ln in lines if not (ln.startswith("- **大蜜蜂（36）**")) ]
lines = [ln for ln in lines if "大蜜蜂蜇到人 20 刻后自尽" not in ln]

# 3) 表格行重排
row = re.compile(r"^\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|")
idx = 0
out = []
for ln in lines:
    m = row.match(ln)
    if m and m.group(3).strip() not in DROP and "名称" not in m.group(3):
        rest = ln[m.end():]
        out.append("| %d | %d | %s |%s" % (idx + 1, idx, m.group(3), rest))
        idx += 1
        continue
    if m and m.group(3).strip() in DROP:
        continue
    out.append(ln)
lines = out

text = "\n".join(lines)
text = re.sub(r"全 \d+ 只", "全 %d 只" % idx, text, count=1)
text = re.sub(r"#pool_size[` ]*[\s`]*75", "#pool_size` 73", text)
text = text.replace("2097152 % 75 = 2", "2097152 % 73 = 54")

with io.open(DOC, "w", encoding="utf-8", newline="\n") as f:
    f.write(text)
print("table rows:", idx)
