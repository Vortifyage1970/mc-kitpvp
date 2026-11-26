import io, os, re, json, glob

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')
ENCH = os.path.join(FN, 'skill', 'enchanter')

ok = True


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


print('== 随机池 ==')
t = read(os.path.join(FN, 'skill', 'earth', 'random.mcfunction'))
pool = int(re.search(r'#pool_size kitpvp\.game (\d+)', t).group(1))
nums = sorted(int(m) for m in re.findall(r'matches (\d+) run function kitpvp:summon/', t))
print('  pool_size =', pool, ' 行数 =', len(nums), ' 范围 =', nums[0], '..', nums[-1])
if len(nums) != pool or nums != list(range(pool)):
    ok = False
    print('  !! 编号不连续或有缺号')
bits = len(re.findall(r'execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp\.rng', t))
space = 128 ** bits
print('  骰子位数 =', bits, ' 空间 =', space, ' 空间 %% pool =', space % pool,
      ' 相对偏差 %.6f%%' % (100.0 * (space % pool) / space))
if space % pool > space * 0.001:
    ok = False
    print('  !! 取模偏差过大')

print('== 谓词 ==')
for p in sorted(glob.glob(os.path.join(ROOT, 'src', 'data', 'kitpvp', 'predicates', 'random', '*.json'))):
    d = json.loads(read(p))
    ch = d.get('chance')
    print('  %-10s chance=%s  1/%.4f' % (os.path.basename(p), ch, 1.0 / ch if ch else 0))

print('== 附魔权重（0..127 全量覆盖且不重叠）==')
for name in ('roll_sword', 'roll_head', 'roll_chest', 'roll_legs', 'roll_feet'):
    t = read(os.path.join(ENCH, name + '.mcfunction'))
    spans = []
    for m in re.finditer(r'matches (\d+)\.\.(\d+) run function kitpvp:skill/enchanter/(\w+)', t):
        lo, hi, fn = int(m.group(1)), int(m.group(2)), m.group(3)
        spans.append((lo, hi, fn))
    cover = []
    for lo, hi, fn in spans:
        cover.extend(range(lo, hi + 1))
    dup = len(cover) - len(set(cover))
    missing = sorted(set(range(128)) - set(cover))
    print('  %-11s 条数=%d 重复=%d 缺=%s' % (name, len(spans), dup, missing if missing else '无'))
    if dup or missing:
        ok = False

print('== 号内分岔（应为 1in2 / 1in3 等，且不能用 run predicate）==')
for p in sorted(glob.glob(os.path.join(FN, 'summon', '*pick*.mcfunction'))):
    t = read(p)
    preds = re.findall(r'(?:if|run) predicate (kitpvp:random/\w+)', t)
    bad = 'run predicate' in t
    print('  %-34s %s %s' % (os.path.basename(p), preds, '!! run predicate 非法' if bad else ''))
    if bad:
        ok = False

print('== 全库非法 run predicate ==')
bad = []
for p in glob.glob(os.path.join(FN, '**', '*.mcfunction'), recursive=True):
    if 'run predicate' in read(p):
        bad.append(os.path.relpath(p, FN))
print('  ', bad if bad else '无')
if bad:
    ok = False

print('\n结论：', 'ALL OK' if ok else '发现问题，见上面 !!')
