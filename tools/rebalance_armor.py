import io, os, re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
SK = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')

# 保护 26/128 = 20.3%，其余 102 格按原比例分摊
NEW = {
    'head': [
        ('apply_head_protection', 0, 25),
        ('apply_head_projectile_protection', 26, 51),
        ('apply_head_respiration', 52, 76),
        ('apply_head_fire_protection', 77, 101),
        ('apply_head_blast_protection', 102, 127),
    ],
    'chest': [
        ('apply_chest_protection', 0, 25),
        ('apply_chest_projectile_protection', 26, 51),
        ('apply_chest_thorns', 52, 76),
        ('apply_chest_fire_protection', 77, 101),
        ('apply_chest_blast_protection', 102, 127),
    ],
    'legs': [
        ('apply_legs_protection', 0, 25),
        ('apply_legs_projectile_protection', 26, 51),
        ('apply_legs_thorns', 52, 76),
        ('apply_legs_fire_protection', 77, 101),
        ('apply_legs_blast_protection', 102, 127),
    ],
    'feet': [
        ('apply_feet_protection', 0, 25),
        ('apply_feet_projectile_protection', 26, 40),
        ('apply_feet_frost_walker', 41, 55),
        ('apply_feet_fire_protection', 56, 70),
        ('apply_feet_blast_protection', 71, 85),
        ('apply_feet_depth_strider', 86, 99),
        ('apply_feet_feather_falling', 100, 113),
        ('apply_feet_soul_speed', 114, 127),
    ],
}

for slot, table in NEW.items():
    fn = 'roll_%s.mcfunction' % slot
    path = os.path.join(SK, fn)
    with io.open(path, 'r', encoding='utf-8') as f:
        lines = f.read().split('\n')
    used = set()
    for i, line in enumerate(lines):
        m = re.search(r'matches (\d+)\.\.(\d+) run function kitpvp:skill/enchanter/(\w+)', line)
        if not m:
            continue
        target = m.group(3)
        for name, lo, hi in table:
            if name == target:
                lines[i] = re.sub(r'matches \d+\.\.\d+ run function',
                                  'matches %d..%d run function' % (lo, hi), line)
                used.add(name)
                break
    assert used == set(n for n, _, _ in table), (slot, used)
    # 校验覆盖 0..127 无重叠
    spans = sorted((lo, hi) for _, lo, hi in table)
    assert spans[0][0] == 0 and spans[-1][1] == 127
    for a, b in zip(spans, spans[1:]):
        assert b[0] == a[1] + 1, (slot, a, b)
    header = '# 给%s掷一次附魔（权重合计 128，保护 26 = 20.3%%）' % {
        'head': '头盔', 'chest': '胸甲', 'legs': '护腿', 'feet': '靴子'}[slot]
    lines[0] = header
    with io.open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write('\n'.join(lines))
    print(slot, 'ok')
