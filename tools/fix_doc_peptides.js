// 更新本地档案里肽类的部分（ai-content 不进 git）
const fs = require('fs');
const p = 'ai-content/08-地球生灵档案.md';
let lines = fs.readFileSync(p, 'utf8').split('\n');

// 1. 删掉寡肽那一行
lines = lines.filter(l => !/^\| 45 \| 44 \| 寡肽 \|/.test(l));

// 2. 地球·≥46 的行，池号 -1
lines = lines.map(l => {
  const m = l.match(/^\| (\d+) \| (\d+) \|/);
  if (!m) return l;
  const earth = parseInt(m[1], 10);
  if (earth < 46) return l;
  return l.replace(/^\| (\d+) \| (\d+) \|/, (s, a, b) => `| ${a} | ${parseInt(b, 10) - 1} |`);
});

// 3. 三条肽的描述
lines = lines.map(l => {
  if (/^\| 46 \| 44 \| 多肽 \|/.test(l))
    return l.replace(/\| 僵尸 · 5 血 \| .* \|$/, '| 僵尸 · 1 血 | 10 只氨基酸（1 血僵尸）竖直嵌套成一串，全体常驻跳跃提升 V |');
  if (/^\| 47 \| 45 \| 环肽 \|/.test(l))
    return l.replace(/\| 僵尸 · 5 血 \| .* \|$/, '| 僵尸 · 1 血 | 8 只氨基酸围成半径 2.5 的八边形，圆心认召唤者，每 2 刻转 22.5° |');
  if (/^\| 67 \| 65 \| β转角 \|/.test(l))
    return l.replace(/\| 僵尸 · 5 血 \| .* \|$/, '| 僵尸 · 1 血 | 竖链 5 只氨基酸 + 尾巴 5 只 Leash 拴在前一只上 |');
  return l;
});

// 4. §2.3 整段重写
const start = lines.findIndex(l => l.startsWith('### 2.3 肽链家族'));
const end = lines.findIndex((l, i) => i > start && l.startsWith('### 2.4'));
if (start < 0 || end < 0) throw new Error('section 2.3 not found');
const section = [
  '### 2.3 肽链家族 46–47、67（同一套零件的三种用法）',
  '',
  '- **零件**：氨基酸 = **1 血僵尸**（`Health:1.0f` + `Attributes.Base:1.0`），平滑石头头（顺带白天不烧）。全部 `Silent:1b`（走路/挨打/死亡都不出声）。**肽键（1 血蠹虫）已全部删除**，现在三种肽都只由氨基酸组成。',
  '- **多肽（46）**：10 只氨基酸竖直嵌套（`Passengers` 9 层，单行约 3.9 KB），全体常驻跳跃提升 V。中间任何一只死了，上面驮的那段会被弹出来（原版骑乘规则）。',
  '- **环肽（47）**：原版做不出骑乘闭环，改成 8 只氨基酸按半径 2.5、彼此 45° 站位，`ring_follow` 每 2 刻转 22.5°（16 格一圈 32 刻）；圆心优先认召唤者（`earth_owner` 与玩家 `etid` 比对），召唤者不在时退化成离圈最近的活玩家。旋转开关 `#ring_spin`（默认 1）。',
  '- **β转角（67）**：竖链 5 只氨基酸（4 层嵌套，底座 `UUID:[I;1900002,1,1,1]`，`~ ~ ~`），尾巴 5 只按 `~ ~ ~-0.75k` 排开、各带 `Leash` 串在前一只身上。**`Leash` 的值必须是复合标签 `{UUID:[I;a,b,c,d]}`**（裸 int 数组会被静默丢弃）；同一函数里同时召出的兄弟不在 UUID 索引里，所以尾巴要写死在同一次执行、各带明确偏移。',
  ''
];
lines.splice(start, end - start, ...section);

// 5. 全局计数
let text = lines.join('\n');
text = text.replace('# 地球生灵档案（全 81 只 · 截至 2026-11-11，已并入 main）', '# 地球生灵档案（全 81 只编号、80 只在池 · 截至 2026-11-11，已并入 main）');
text = text.replace(/（现在是 81）/g, '（现在是 80）');
text = text.replace(/全部 941 个 `\.mcfunction`/, '全部 1034 个 `.mcfunction`');
text = text.replace(/池 0\.\.80 无空号/, '池 0..79 无空号（地球·45 原寡肽已删，编号不复用）');
text = text.replace('## 1. 总表（81 只，按池号）', '## 1. 总表（80 只在池，按池号；地球·45 空号）');
text = text.replace(/`#pool_size 81`/g, '`#pool_size 80`');
text = text.replace('池号后移', '池号后移');
fs.writeFileSync(p, text, 'utf8');
console.log('done');
