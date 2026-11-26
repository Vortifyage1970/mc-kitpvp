const fs = require('fs');
const p = 'src/data/kitpvp/functions/skill/earth/random.mcfunction';
let lines = fs.readFileSync(p, 'utf8').split('\n');
const isS = l => /^execute if score @s kitpvp\.rng matches \d+ run function kitpvp:summon\/\S+$/.test(l.trim());
const drop = /earth_oracle|earth_antitank|summon\/earth_flyer$|summon\/earth_polypeptide$|earth_polypeptide_betaturn/;
lines = lines.filter(l => !(isS(l) && drop.test(l.trim())));
// 共用一个池号：在多肽原来那一行处插入 chain
const at = lines.findIndex(l => isS(l) && /earth_cyclic/.test(l));
if (at < 0) throw new Error('anchor');
lines.splice(at, 0, 'execute if score @s kitpvp.rng matches 0 run function kitpvp:summon/earth_peptide_chain');
let n = 0;
lines = lines.map(l => isS(l) ? l.replace(/matches \d+/, 'matches ' + (n++)) : l);
let t = lines.join('\n')
  .replace(/scoreboard players set #pool_size kitpvp\.game \d+/, 'scoreboard players set #pool_size kitpvp.game ' + n)
  .replace(/128 不是 \d+ 的倍数/, '128 不是 ' + n + ' 的倍数')
  .replace(/2097152 % \d+ = \d+/, '2097152 % ' + n + ' = ' + (2097152 % n))
  .replace(/实现数（\d+）/, '实现数（' + n + '）');
fs.writeFileSync(p, t, 'utf8');
console.log('pool =', n, 'mod =', 2097152 % n);
