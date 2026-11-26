// 一次性生成器：把肽类生灵改成"纯氨基酸"结构（不含肽键蠹虫）
//   node tools/gen_peptides.js
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const FN = path.join(ROOT, 'src', 'data', 'kitpvp', 'functions');

const AA_NAME = '氨基酸';
const write = (p, s) => fs.writeFileSync(p, s, { encoding: 'utf8' });

function zombie(tags, extra = '') {
  return '{id:"minecraft:zombie",Silent:1b,Tags:[' + tags.map(t => JSON.stringify(t)).join(',') + '],' +
    'Health:1.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:1.0}],' +
    'ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],' +
    'CustomName:\'{"text":"' + AA_NAME + '","color":"green"}\',CustomNameVisible:0b,' +
    'PersistenceRequired:1b,CanPickUpLoot:0b' + extra + '}';
}

// ---------- 多肽：10 只氨基酸竖直嵌套 ----------
function polypeptide() {
  const base = ['kitpvp.earth_minion', 'kitpvp.earth_minion_new', 'kitpvp.earth_polypeptide', 'kitpvp.earth_amino'];
  let inner = zombie(base);
  for (let i = 0; i < 9; i++) inner = zombie(base, ',Passengers:[' + inner + ']');
  const lines = [
    '# 地球·46 多肽：十只氨基酸（1 血僵尸）竖直嵌套成一串，全体常驻跳跃提升 V',
    '# 结构自下而上 Z Z Z … Z（10 节）；嵌套 9 层 Passengers，整串只有底座那只是"本体"',
    '# 中间任何一节死了，它上面驮的那一段会被弹出来（链子断开），这是原版骑乘规则',
    '# 外形：头戴平滑石头（smooth_stone 占头槽，顺带让它白天不会自燃）；1 血 = 一刀一个氨基酸',
    'summon minecraft:zombie ~ ~ ~ ' + inner,
    'effect give @e[tag=kitpvp.earth_polypeptide] minecraft:jump_boost infinite 4 true',
    ''
  ];
  write(path.join(FN, 'summon', 'earth_polypeptide.mcfunction'), lines.join('\n'));
}

// ---------- 环肽：8 只氨基酸围圈 ----------
function cyclic() {
  const lines = [
    '# 地球·47 环肽（实验）：8 只氨基酸围成半径 2.5 的八边形，不靠骑乘 —— 原版做不到"骑成闭环"',
    '# 圈心 = 召唤者（靠 earth_owner/etid 认人）；召唤者不在时退化成"离圈最近的活玩家"',
    '# 旋转开关：#ring_spin=1（默认开）每 2 刻把十六个方位轮换一格（22.5°，一圈 32 刻）；改成 0 就是固定方位跟着人平移',
    '# NoAI：不让它们自己乱走，位置完全由 tp 决定；1 血，头戴平滑石头',
    ''
  ];
  for (let i = 1; i <= 8; i++) {
    const tags = ['kitpvp.earth_minion', 'kitpvp.earth_minion_new', 'kitpvp.earth_cyclic', 'kitpvp.earth_ring_' + i];
    lines.push('summon minecraft:zombie ~ ~ ~ ' + zombie(tags, ',NoAI:1b'));
  }
  lines.push(
    '',
    '# 关闭召唤播报的草地音',
    'scoreboard players set #summon_quiet kitpvp.game 1',
    '',
    '# 复位旋转状态：默认转（想停就 /scoreboard players set #ring_spin kitpvp.game 0）',
    'scoreboard players set #ring_spin kitpvp.game 1',
    'scoreboard players set #ring_rot kitpvp.game 0',
    ''
  );
  write(path.join(FN, 'summon', 'earth_cyclic.mcfunction'), lines.join('\n'));
}

// ---------- β转角：竖链 5 只 + 拴尾 5 只 ----------
function betaturn() {
  const base = ['kitpvp.earth_minion', 'kitpvp.earth_minion_new', 'kitpvp.earth_polypeptide_betaturn', 'kitpvp.earth_amino'];
  let inner = zombie(base);
  for (let i = 0; i < 3; i++) inner = zombie(base, ',Passengers:[' + inner + ']');
  const head = [
    '# 地球·67 多肽_β转角：竖链 5 只氨基酸 + 尾巴 5 只氨基酸（全部 1 血，没有肽键）',
    '# ★ 竖链用 Passengers 嵌套（不用 tick 逐只 tp 叠柱：那样底座一死，上面几节会僵在半空；Passengers 是原版结构，中间一层死了上面的会被弹下来）',
    '# ★ 底座挂 UUID = [I;1900002,1,1,1]：尾巴第 1 节靠 Leash:{UUID:[I;1900002,1,1,1]} 拴在它身上，后面一节拴前一节',
    'kill @e[tag=kitpvp.earth_polypeptide_betaturn]',
    'kill @e[tag=kitpvp.earth_polypeptide_betaturn_rope]',
    '# ★ 链子被 kill/打死时原版会把拴绳当物品掉在脚下（这就是"莫名多出来的拴绳"）：顺手清掉召唤点附近的',
    'kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..8]',
    '# ★ 尾巴与底座在**同一次执行**里召出：schedule 排的函数没有玩家坐标，会跑到世界出生点去',
    '#   每节出生点已经按 0.75 格排好（~ ~ ~-0.75k），Leash 再按 UUID 串起来',
    ''
  ];
  const rootTags = base.concat(['kitpvp.earth_polypeptide_betaturn_a']);
  const rootNbt = zombie(rootTags, ',UUID:[I;1900002,1,1,1],Passengers:[' + inner + ']');
  const out = head.concat(['summon minecraft:zombie ~ ~ ~ ' + rootNbt]);

  let prev = '[I;1900002,1,1,1]';
  for (let k = 1; k <= 5; k++) {
    const uuid = '[I;1900001,' + (k + 1) + ',1,1]';
    const tags = base.concat(['kitpvp.earth_polypeptide_betaturn_tail' + k]);
    const nbt = zombie(tags, ',UUID:' + uuid + ',Leash:{UUID:' + prev + '}');
    out.push('summon minecraft:zombie ~ ~ ~' + (-0.75 * k) + ' ' + nbt);
    prev = uuid;
  }
  out.push('');
  write(path.join(FN, 'summon', 'earth_polypeptide_betaturn.mcfunction'), out.join('\n'));
}

// ---------- ring_pos_0..15：8 个点，16 个旋转格 ----------
function ringPos() {
  const R = 2.5;
  const fmt = v => {
    const r = Math.round(v * 100) / 100;
    if (Math.abs(r) < 0.005) return '~';
    return '~' + String(r);
  };
  for (let rot = 0; rot < 16; rot++) {
    const lines = [
      '# 环肽方位 ' + rot + '：8 只氨基酸，半径 ' + R + '、彼此 45°，表里是"旋转 ' + rot + ' 格"时各自的相对坐标',
      ''
    ];
    for (let i = 1; i <= 8; i++) {
      const deg = 45 * (i - 1) + 22.5 * rot;
      const rad = deg * Math.PI / 180;
      lines.push('execute at @s run tp @e[tag=kitpvp.earth_ring_' + i + '] ' + fmt(R * Math.cos(rad)) + ' ~ ' + fmt(R * Math.sin(rad)));
    }
    lines.push('');
    write(path.join(FN, 'skill', 'earth', 'ring_pos_' + rot + '.mcfunction'), lines.join('\n'));
  }
}

// ---------- 池子：删掉寡肽并重新编号 ----------
function random() {
  const p = path.join(FN, 'skill', 'earth', 'random.mcfunction');
  const src = fs.readFileSync(p, 'utf8').split('\n');
  let n = 0;
  const out = [];
  for (const line of src) {
    if (/run function kitpvp:summon\/earth_oligopeptide\s*$/.test(line)) continue;
    if (/^execute if score @s kitpvp\.rng matches \d+ run function kitpvp:summon\/\S+\s*$/.test(line)) {
      out.push(line.replace(/matches \d+/, 'matches ' + n));
      n++;
    } else if (/^scoreboard players set #pool_size kitpvp\.game \d+/.test(line)) {
      out.push({ pool: true, line });
    } else {
      out.push(line);
    }
  }
  const text = out.map(x => (x && x.pool) ? x.line.replace(/\d+$/, String(n)) : x).join('\n').replace(/\x2081\b/g, ' 80').replace(/128 不是 81 的倍数/, '128 不是 80 的倍数')
    .replace(/2097152 % 81 = 62/, '2097152 % 80 = 32').replace(/实现数（81）/, '实现数（80）');
  write(p, text);
  return n;
}

polypeptide();
cyclic();
betaturn();
ringPos();
const count = random();
console.log('pool entries =', count);
