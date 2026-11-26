import io, os, glob

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
ENCH = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


kept = 0
stripped = 0
for p in sorted(glob.glob(os.path.join(ENCH, 'apply_*.mcfunction'))):
    t = read(p)
    name = os.path.basename(p)
    if name.startswith('apply_sword_'):
        # 每轮强化的第一行：保留前导空行，用来把一轮和下一轮隔开
        if '{"text":"[附魔] ' in t:
            t = t.replace('{"text":"[附魔] ', '{"text":"\\n[附魔] ')
            kept += 1
    else:
        # 同一轮里的第 2..4 行：紧贴在上一行下面
        if '{"text":"\\n[附魔] ' in t:
            t = t.replace('{"text":"\\n[附魔] ', '{"text":"[附魔] ')
            stripped += 1
    write(p, t)

print('sword lines with blank line:', kept, ' armor lines joined:', stripped)
