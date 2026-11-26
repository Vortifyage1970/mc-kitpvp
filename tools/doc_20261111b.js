const fs = require('fs');
const DOC = 'ai-content/08-地球生灵档案.md';
const POOL = 'src/data/kitpvp/functions/skill/earth/random.mcfunction';

// ---- 池号映射 ----
const poolLines = fs.readFileSync(POOL, 'utf8').split('\n');
const map = new Map();
let idx = 0;
for (const l of poolLines) {
  const m = l.match(/matches (\d+) run function kitpvp:summon\/(\S+)\s*$/);
  if (m) {
    map.set(m[2], Number(m[1]));
    idx++;
  }
}
map.set('earth_polypeptide', map.get('earth_peptide_chain'));
map.set('earth_polypeptide_betaturn', map.get('earth_peptide_chain'));

let lines = fs.readFileSync(DOC, 'utf8').split('\n');
const warn = [];

// ---- 1. 总表：删掉已删生灵的行、按代码重写池号 ----
lines = lines.filter(l => {
  const m = l.match(/^\| (\d+) \| (\d+) \| [^|]+ \| `([a-z0-9_]+)` \|/);
  if (!m) return true;
  if (!map.has(m[3])) return false;
  return true;
});
lines = lines.map(l => {
  const m = l.match(/^\| (\d+) \| (\d+) \|/);
  if (!m) return l;
  const row = l.match(/`([a-z0-9_]+)`/);
  if (!row) return l;
  const p = map.get(row[1]);
  if (p === undefined) return l;
  return l.replace(/^\| (\d+) \| (\d+) \|/, `| ${m[1]} | ${p} |`);
});

// ---- 2. 删掉整节：飞行器、反装甲步兵 ----
function dropSection(title) {
  const start = lines.findIndex(l => l.startsWith(title));
  if (start < 0) { warn.push('section not found: ' + title); return; }
  let end = start + 1;
  while (end < lines.length && !/^#{2,3} /.test(lines[end])) end++;
  // 连同前面可能存在的 "---" 分隔与空行一起删
  let s = start;
  while (s > 0 && (lines[s - 1].trim() === '' || lines[s - 1].trim() === '---')) s--;
  lines.splice(s, end - s);
}
dropSection('### 2.8 飞行器（69）');
dropSection('### 2.15 反装甲步兵（78）');

const rep = (from, to) => {
  const i = lines.findIndex(l => l.includes(from));
  if (i < 0) { warn.push('missing: ' + from.slice(0, 30)); return; }
  lines[i] = lines[i].split(from).join(to);
};

// ---- 3. 逐条改 ----
rep('胜者：Chincken_brothers', '胜者：Chicken_brothers');
rep('Chincken_brothers', 'Chicken_brothers');
lines = lines.filter(l => !l.startsWith('- **预言家（49）**'));

rep('红色赤狐，7 格内持续降速（复用职业金星的冷度管道）', '红色赤狐，6 格内持续缓慢 III（不再走冷度管道）');
rep('- **金星（52）**：红色赤狐（`Type:0b`、`Sleeping:0b`、`Sitting:0b`），走哪冷到哪：7 格内持续降速，复用职业金星的冷度管道。',
  '- **金星（52）**：红色赤狐（`Type:0b`、`Sleeping:0b`、`Sitting:0b`），走哪冷到哪：6 格内持续**缓慢 III**（`slowness 2 2 true` 每刻刷新，离开 2 秒解除），召唤者不冻。');

rep('蠹虫 · 15 血', '蠹虫 · 9 血');
rep('3 秒一次 3 点魔法伤害', '3 秒一次 1 点魔法伤害（召唤者不索敌）');
rep('乘客僵尸 15 血 + 抗性 II', '乘客僵尸 **9 血** + 抗性 II');
rep('`damage @s 3 minecraft:magic by @e[乘客]`', '`damage @s 1 minecraft:magic by @e[乘客]`');

rep('被踩破土 + 缓慢 III', '被踩破土 + 缓慢 III；**埋它的那个人踩不爆**（`mh_summoner` 分 + `manhole_try` 里打豁免 tag）');
rep('- **井盖（61）**：召唤时直接埋进脚下方块 2 格（`Invulnerable` + `NoAI`），视野里完全看不见；被踩后破土 + 缓慢 III。',
  '- **井盖（61）**：召唤时直接埋进脚下方块 2 格（`Invulnerable` + `NoAI`），视野里完全看不见；别人踩上去才破土 + 缓慢 III。**召唤者自己踩不爆**：`manhole_try` 把"主人（`earth_owner`=`etid`）或 `mh_summoner=1` 的人"打上 `mh_exempt`，选择器排除掉。');

rep('- **音符盒（63）**：血量一下降就随机播报一个乐器 + 音高',
  '- **音符盒（63）**：手上拿一张**锋利 III 的唱片**（`music_disc_cat` + `sharpness 3`）；血量一下降就随机播报一个乐器 + 音高');

rep('名字「罐子」，20 血，正常 AI', '名字「罐子」，**6 血**，正常 AI');
rep('`Health:10.0f` + `Base:10.0`（大罐子 20 血）', '`Health:6.0f` + `Base:6.0`（和大罐子一样脆）');

rep('名字「蜂巢」，20 血，正常 AI', '名字「蜂巢」，**15 血**，正常 AI');
// 蜂巢三条：计数 / 给几个 / 给谁
{
  const i = lines.findIndex(l => l.startsWith('- **挨打计数**'));
  if (i >= 0) lines[i] = '- **判定**：`advancement kitpvp:player/hive_struck`（`player_hurt_entity` + `conditions.entity` 匹配 `type: zombie` 且 `Tags:["kitpvp.earth_hive"]`）。谁打的就触发给谁，奖励函数 `hive_struck` 先把 advancement 撤销再发东西，所以连击每一刀都算。';
  else warn.push('hive hit bullet missing');
  const j = lines.findIndex(l => l.startsWith('- **一次给几个**'));
  if (j >= 0) lines[j] = '- **一次给几个**：**每下固定 3 张**（`hive_struck` 里连调三次 `hive_give`），不再按挨打次数递增。';
  else warn.push('hive count bullet missing');
  const k = lines.findIndex(l => l.startsWith('- **给谁**'));
  if (k >= 0) lines[k] = '- **给谁**：**只给打它的那名玩家**。advancement 由被打的那一下触发、奖励函数以"出手的人"身份执行，旁边的人不沾；创造/旁观/召唤者都不会触发（advancement 只在真打到时才会给）。';
  else warn.push('hive who bullet missing');
}

rep('召唤时 `earth_cd_a 300`（15 秒）', '召唤时 `earth_cd_a 200`（10 秒）');
rep('函数结尾再把 `earth_cd_a` 设回 300', '函数结尾再把 `earth_cd_a` 设回 200');
rep('**全部 15 秒**', '**全部 10 秒**');

rep('**20 血**；右手一把**白板弓**', '**10 血**；右手一把**白板弓**');

rep('- **定位**：一个"打不动的抗性外壳', '- **虚弱 I**：尸壳常驻 `weakness infinite 0`（近战伤害砍半），配合"有抗性 V 打不死、但也砍不疼"的定位。\n- **定位**：一个"打不动的抗性外壳');

// ---- 4. 计数 ----
{
  let text = lines.join('\n');
  const n = map.size; // 注意 map 里多了两个别名
  const real = idx;
  text = text.replace(/# 地球生灵档案（[^）]*）/, `# 地球生灵档案（80 个编号、${real} 只在池 · 截至 2026-11-11）`);
  text = text.replace(/## 1\. 总表（[^）]*）/, `## 1. 总表（${real} 只在池，按池号；地球·45 / 49 / 69 / 78 已删）`);
  text = text.replace(/池 0\.\.79 无空号（地球·45 原寡肽已删，编号不复用）/, `池 0..${real - 1} 无空号（地球·45 寡肽、49 预言家、69 飞行器、78 反装甲步兵已删，编号不复用）`);
  text = text.replace(/（现在是 80）/g, `（现在是 ${real}）`);
  text = text.replace(/`#pool_size 80`/g, '`#pool_size ' + real + '`');
  fs.writeFileSync(DOC, text, 'utf8');
}
console.log('pool entries', idx);
if (warn.length) console.log('WARN:\n' + warn.join('\n'));
