const fs = require('fs');
const p = 'ai-content/08-地球生灵档案.md';
let L = fs.readFileSync(p, 'utf8').split('\n');
const set = (needle, fn) => {
  const i = L.findIndex(l => l.includes(needle));
  if (i < 0) { console.log('miss', needle.slice(0, 24)); return; }
  L[i] = fn(L[i]);
};

set('- 卡片里那一长串名称', () => '- 卡片里那一长串名称按池序维护，改名/删生灵时要同步（2026-11-11 删掉预言家 / 飞行器 / 反装甲步兵）。');
set('和 69 号飞行器共用', l => l.replace('和 69 号飞行器共用"分两帧召 + UUID 重试"的骨架', '沿用"分两帧召 + UUID 重试"的骨架（69 号飞行器已删，这套写法保留在这里）'));
set('- **为什么是 24 格不是 3 格**', () => '- **为什么是 24 格不是 3 格**：支援者会在两刻后被提到 30 格，3 格半径够不着它。');

const i3 = L.findIndex(l => l.startsWith('- **多肽（46）**'));
if (i3 >= 0) L.splice(i3, 0, '- **多肽（46）与 β转角（67）共用池号 44**：`earth_peptide_chain` 用 `store success` 掷一次 `random/1in2`，五五开再转给其中一个。');

const i5 = L.findIndex(l => l.startsWith('1. **飞行器**'));
if (i5 >= 0) L.splice(i5, 1);

fs.writeFileSync(p, L.join('\n'), 'utf8');
console.log('ok');
