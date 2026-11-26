import io, os, re

FN = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'src', 'data', 'kitpvp', 'functions')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


# 1) load.mcfunction：每条 bossbar add 之后强制再 set 一次名字（add 对已存在的 bossbar 无效）
p = os.path.join(FN, 'load.mcfunction')
lines = read(p).split('\n')
out = []
for ln in lines:
    out.append(ln)
    m = re.match(r'bossbar add kitpvp:ench_hud_(\d) (\{.*\})$', ln)
    if m:
        n, js = m.group(1), m.group(2)
        out.append('bossbar set kitpvp:ench_hud_%s name %s' % (n, js))
text = '\n'.join(out)
text = re.sub(r'(bossbar set kitpvp:ench_hud_\d+) color pink', r'\1 color blue', text)
write(p, text)

# 2) hud.mcfunction：常态蓝色、满级黄色
p = os.path.join(FN, 'skill', 'enchanter', 'hud.mcfunction')
t = read(p)
t = re.sub(r'(bossbar set kitpvp:ench_hud_\d+) color pink', r'\1 color blue', t)
write(p, t)

print('name lines:', text.count('bossbar set kitpvp:ench_hud_') - text.count('style progress') - text.count('max 1000') - text.count('value 0') - text.count('players'))
print('blue lines:', text.count('color blue'))
