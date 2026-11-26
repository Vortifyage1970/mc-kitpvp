// 2026-11-11 批量改造：删三只、肽共用池号、若干数值/机制
const fs = require('fs');
const path = require('path');
const FN = path.join('src', 'data', 'kitpvp', 'functions');
const rd = p => fs.readFileSync(p, 'utf8');
const wr = (p, s) => fs.writeFileSync(p, s, 'utf8');
const must = (cond, msg) => { if (!cond) throw new Error('FAIL: ' + msg); };

// ---------- 1. 删除文件 ----------
const del = [
  'summon/earth_oracle.mcfunction',
  'skill/earth/oracle_speak.mcfunction',
  'skill/earth/oracle_say_1.mcfunction', 'skill/earth/oracle_say_2.mcfunction', 'skill/earth/oracle_say_3.mcfunction',
  'skill/earth/oracle_say_4.mcfunction', 'skill/earth/oracle_say_5.mcfunction',
  'summon/earth_antitank.mcfunction',
  'skill/earth/antitank_tick.mcfunction', 'skill/earth/antitank_fire.mcfunction',
  'skill/earth/antitank_shell_tick.mcfunction', 'skill/earth/antitank_burst.mcfunction',
  'summon/earth_flyer.mcfunction', 'summon/earth_flyer_a.mcfunction', 'summon/earth_flyer_b.mcfunction',
  'skill/earth/flyer_tick.mcfunction',
  'debug/flyer_test.mcfunction', 'debug/flyer_test_b.mcfunction', 'debug/flyer_watch.mcfunction',
  'debug/flyer_probe.mcfunction', 'debug/flyer_probe_b.mcfunction',
  'skill/earth/hive_hit.mcfunction'
];
for (const f of del) {
  const p = path.join(FN, f);
  must(fs.existsSync(p), 'missing ' + f);
  fs.unlinkSync(p);
}

// ---------- 2. tick.mcfunction 摘掉调用行 / 改井盖 ----------
{
  const p = path.join(FN, 'tick.mcfunction');
  let lines = rd(p).split('\n');
  const before = lines.length;
  lines = lines.filter(l => !/kitpvp\.earth_antitank|kitpvp\.at_shell|kitpvp\.earth_oracle|kitpvp\.earth_flyer_carrier/.test(l)
    && !/kitpvp\.earth_hive,nbt=\{HurtTime/.test(l));
  must(lines.length === before - 5, 'tick removed ' + (before - lines.length) + ' lines (expect 5)');
  const idx = lines.findIndex(l => l.includes('kitpvp.earth_manhole,scores='));
  must(idx >= 0, 'manhole tick line');
  lines[idx] = 'execute as @e[tag=kitpvp.earth_manhole,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/manhole_try';
  wr(p, lines.join('\n'));
}

// ---------- 3. 井盖：不被召唤者触发 ----------
wr(path.join(FN, 'skill', 'earth', 'manhole_try.mcfunction'), [
  '# @s = 井盖。装填期走完后由 tick 调进来：只有"不属于召唤者"的人站在正上方才会破土',
  '# 两种认人口径：earth_owner/etid（正常召唤）、mh_summoner 分（手动 function 召唤时靠它顶上）',
  'tag @a remove kitpvp.mh_exempt',
  'scoreboard players set #mh_own kitpvp.game 0',
  'scoreboard players operation #mh_own kitpvp.game = @s kitpvp.earth_owner',
  'execute if score #mh_own kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #mh_own kitpvp.game run tag @s add kitpvp.mh_exempt',
  'execute as @a if score @s kitpvp.mh_summoner matches 1 run tag @s add kitpvp.mh_exempt',
  'execute at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.mh_exempt,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop',
  'tag @a remove kitpvp.mh_exempt',
  ''
].join('\n'));
{
  const p = path.join(FN, 'summon', 'earth_manhole.mcfunction');
  let s = rd(p);
  must(!s.includes('mh_summoner'), 'manhole already patched');
  s = s.trimEnd('\n') + '\nscoreboard players set @a kitpvp.mh_summoner 0\nscoreboard players set @s kitpvp.mh_summoner 1\n';
  wr(p, s);
}

// ---------- 4. 金星：6 格内缓慢 III ----------
wr(path.join(FN, 'skill', 'earth', 'venus_chill_mark.mcfunction'), [
  '# @s = 金星（狐狸）：6 格内"不是召唤者"的活人持续缓慢 III（amplifier 2），离开范围 2 秒后解除',
  '# 归属先归零再 operation：魂石路径/手动召出来的没有 earth_owner，源分缺失会留上一只的旧值',
  'scoreboard players set #venus_owner kitpvp.game 0',
  'scoreboard players operation #venus_owner kitpvp.game = @s kitpvp.earth_owner',
  '# 无主（earth_owner 为空 = 0）：谁都冷，免得"手动召的狐狸冻不住人"',
  'execute if score #venus_owner kitpvp.game matches ..0 as @a[distance=..6,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s run effect give @s minecraft:slowness 2 2 true',
  '# 有主：只有不属于这一只的玩家才吃（召唤者自己免疫）',
  'execute if score #venus_owner kitpvp.game matches 1.. as @a[distance=..6,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #venus_owner kitpvp.game at @s run effect give @s minecraft:slowness 2 2 true',
  ''
].join('\n'));

// ---------- 5. 深池飞行兵：9 血、伤害 1、不索召唤者 ----------
{
  const p = path.join(FN, 'summon', 'earth_dublinn.mcfunction');
  let s = rd(p);
  must(s.includes('Health:15.0f') && s.includes('Base:15.0'), 'dublinn health anchor');
  s = s.replace('Health:15.0f', 'Health:9.0f').replace('Base:15.0', 'Base:9.0');
  must(!s.includes('dl_summoner'), 'dublinn already patched');
  s = s.trimEnd('\n') + '\nscoreboard players set @a kitpvp.dl_summoner 0\nscoreboard players set @s kitpvp.dl_summoner 1\n';
  wr(p, s);

  const q = path.join(FN, 'skill', 'earth', 'dublinn_strike.mcfunction');
  let t = rd(q);
  must(t.includes('damage @s 3 minecraft:magic'), 'dublinn damage anchor');
  t = t.replace('damage @s 3 minecraft:magic', 'damage @s 1 minecraft:magic');
  t = t.replace('# ★ 手感：60 刻（3 秒）一下、3 点、damage 类型用 magic', '# ★ 手感：60 刻（3 秒）一下、1 点、damage 类型用 magic');
  // 两种口径都排除召唤者（手动召唤没有 earth_owner 时靠 dl_summoner 分）
  const a1 = 'tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #dl_owner';
  must(t.includes(a1), 'dublinn owner branch anchor');
  t = t.replace(a1, 'tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.dl_summoner matches 1 unless score @s kitpvp.etid = #dl_owner');
  const a2 = '# 2) 无主：2 格内所有活人（含召唤者）';
  must(t.includes(a2), 'dublinn ownerless comment');
  t = t.replace(a2, '# 2) 无主：2 格内所有活人（召唤者除外，靠 dl_summoner 分认人）');
  const a3 = 'at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..2,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.dl_victim';
  must(t.includes(a3), 'dublinn ownerless selector anchor');
  t = t.replace(a3, 'at @e[tag=kitpvp.earth_dublinn_zombie,distance=..3,sort=nearest,limit=1] as @a[distance=..2,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.dl_summoner matches 1 run tag @s add kitpvp.dl_victim');
  wr(q, t);
}

// ---------- 6. 音符盒：手上一张锋利 III 的唱片 ----------
{
  const p = path.join(FN, 'summon', 'earth_noteblock.mcfunction');
  let s = rd(p);
  must(s.includes('HandItems:[{},{}]'), 'noteblock hand anchor');
  s = s.replace('HandItems:[{},{}]', 'HandItems:[{id:"minecraft:music_disc_cat",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:3s}]}},{}]');
  wr(p, s);
}

// ---------- 7. 罐子 6 血 ----------
{
  const p = path.join(FN, 'summon', 'earth_jar.mcfunction');
  let s = rd(p);
  must(!s.includes('Health:'), 'jar already has health');
  s = s.replace('CanPickUpLoot:0b,', 'CanPickUpLoot:0b,Health:6.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:6.0}],');
  wr(p, s);
  const q = path.join(FN, 'summon', 'earth_jar_small.mcfunction');
  let t = rd(q);
  must(t.includes('Health:10.0f') && t.includes('Base:10.0'), 'jar small anchor');
  t = t.replace('Health:10.0f', 'Health:6.0f').replace('Base:10.0', 'Base:6.0')
    .replace('10 血（比大罐子的 20 血脆一半）', '6 血（和大罐子一样脆）');
  wr(q, t);
}

// ---------- 8. 蜂巢：15 血 ----------
{
  const p = path.join(FN, 'summon', 'earth_hive.mcfunction');
  let s = rd(p);
  must(!s.includes('Health:'), 'hive already has health');
  s = s.replace('CanPickUpLoot:0b,', 'CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],');
  s = s.replace('# 计数在 kitpvp.hive_hits 上：第 1 下 1 个、第 2 下 2 个、第 3 下及以后每次 3 个', '# 判定走 advancement（player_hurt_entity 匹配这一只）：谁打的就塞给谁，每下固定 3 张');
  wr(p, s);
}

// ---------- 9. 酿造台：10 秒一发，药效 10 秒 ----------
{
  for (const f of ['summon/earth_brewer.mcfunction', 'skill/earth/brewer_drop.mcfunction']) {
    const p = path.join(FN, f);
    let s = rd(p);
    must(s.includes('kitpvp.earth_cd_a 300'), f + ' cd anchor');
    s = s.replace('kitpvp.earth_cd_a 300', 'kitpvp.earth_cd_a 200');
    wr(p, s);
  }
  const p = path.join(FN, 'skill', 'earth', 'brewer_break.mcfunction');
  let s = rd(p);
  for (const eff of ['strength', 'speed', 'nausea', 'resistance']) {
    const from = `minecraft:${eff} 15 0 true`;
    must(s.includes(from), 'brewer effect ' + eff);
    s = s.replace(from, `minecraft:${eff} 10 0 true`);
  }
  wr(p, s);
}

// ---------- 10. 土星 10 血 ----------
{
  const p = path.join(FN, 'summon', 'earth_saturn.mcfunction');
  let s = rd(p);
  must(s.includes('Health:20.0f'), 'saturn health anchor');
  s = s.replace('Health:20.0f', 'Health:10.0f').replace('Base:20.0', 'Base:10.0');
  wr(p, s);
}

// ---------- 11. 冥王星：尸壳 + 虚弱 I ----------
{
  const p = path.join(FN, 'summon', 'earth_pluto.mcfunction');
  let s = rd(p);
  must(!s.includes('earth_pluto_carrier] minecraft:weakness'), 'pluto weakness exists');
  s = s.trimEnd('\n') + '\n# 尸壳（外壳）常驻虚弱 I：近战伤害砍半，靠"打不动人、但抗性 V 也打不死"占点\nexecute as @e[tag=kitpvp.earth_pluto_carrier] run effect give @s minecraft:weakness infinite 0 true\n';
  wr(p, s);
}

// ---------- 12. 赢家名字 ----------
{
  const p = path.join(FN, 'summon', 'earth_winner.mcfunction');
  let s = rd(p);
  must(s.includes('Chincken_brothers'), 'winner name anchor');
  s = s.split('Chincken_brothers').join('Chicken_brothers');
  wr(p, s);
}

// ---------- 13. 多肽 / β转角 共用一个池号 ----------
wr(path.join(FN, 'summon', 'earth_peptide_chain.mcfunction'), [
  '# 多肽与 β转角 共用一个池号：五五开（predicate 只掷一次，用 store success 取结果，避免两次 if/unless 各掷一次变成 50/25/25）',
  'execute store success score #pc_pick kitpvp.game run predicate kitpvp:random/1in2',
  'execute if score #pc_pick kitpvp.game matches 1 run function kitpvp:summon/earth_polypeptide',
  'execute if score #pc_pick kitpvp.game matches 0 run function kitpvp:summon/earth_polypeptide_betaturn',
  ''
].join('\n'));

// ---------- 14. 池子重排 ----------
{
  const p = path.join(FN, 'skill', 'earth', 'random.mcfunction');
  let lines = rd(p).split('\n');
  const isSummon = l => /^execute if score @s kitpvp\.rng matches \d+ run function kitpvp:summon\/\S+\s*$/.test(l);
  const before = lines.filter(isSummon).length;
  lines = lines.filter(l => !/earth_oracle|earth_antitank|earth_flyer\b/.test(l) || !isSummon(l));
  lines = lines.map(l => isSummon(l) && /earth_polypeptide_betaturn/.test(l)
    ? 'execute if score @s kitpvp.rng matches 0 run function kitpvp:summon/earth_peptide_chain' : l);
  let n = 0;
  lines = lines.map(l => isSummon(l) ? l.replace(/matches \d+/, 'matches ' + (n++)) : l);
  let text = lines.join('\n')
    .replace(/scoreboard players set #pool_size kitpvp\.game \d+/, 'scoreboard players set #pool_size kitpvp.game ' + n)
    .replace(/128 不是 80 的倍数/, '128 不是 ' + n + ' 的倍数')
    .replace(/2097152 % 80 = 62/, '2097152 % ' + n + ' = ' + (2097152 % n))
    .replace(/实现数（80）/, '实现数（' + n + '）');
  wr(p, text);
  console.log('pool', before, '->', n);
}

// ---------- 15. 卡片名串 ----------
{
  const p = path.join(FN, 'kit', 'info', 'earth.mcfunction');
  let s = rd(p);
  const reps = [
    ['多肽 / 环肽', '多肽（含 β转角） / 环肽'],
    [' / 赢家 / 预言家 / 内卫', ' / 赢家 / 内卫'],
    [' / 串联体 / 飞行器 / 迫击炮', ' / 串联体 / 迫击炮'],
    [' / 反装甲步兵 / 土星', ' / 土星'],
    [' / 多肽_β转角', '']
  ];
  for (const [a, b] of reps) {
    must(s.includes(a), 'card anchor ' + a);
    s = s.split(a).join(b);
  }
  wr(p, s);
}

// ---------- 16. load：新增三个计分项 ----------
{
  const p = path.join(FN, 'load.mcfunction');
  let s = rd(p);
  for (const line of [
    'scoreboard objectives add kitpvp.dl_summoner dummy "这一只深池飞行兵是谁召的（1 = 召唤者本人，不索敌）"',
    'scoreboard objectives add kitpvp.mh_summoner dummy "这一只井盖是谁埋的（1 = 召唤者本人，不触发）"'
  ]) {
    const key = line.split(' ')[3];
    if (!s.includes(key)) s = s.trimEnd('\n') + '\n' + line + '\n';
  }
  wr(p, s);
}

console.log('done');
