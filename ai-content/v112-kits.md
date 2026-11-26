# 1.12.2 职业战争：命令方块解析

- 命令方块总数：1689（auto=1 的循环块 1425 个）
- 提到 KitNum 的命令：1724 条，覆盖 63 个职业编号
- 编号来源：`score_KitNum=<n>` / `score_KitNum_min=<n>` 选择器

| KitNum | 命令数 | 物品（give/clear/replaceitem） | 效果 | 召唤 | 自己的计分板 |
|---|---|---|---|---|---|
| 1 | 2 | — | speed×2 | — | — |
| 2 | 12 | — | minecraft×2, invisibility×2 | — | Hitten×2, MatchStart×2, DeathCount×2 |
| 3 | 4 | — | jump_boost×2, speed×2 | — | — |
| 4 | 4 | — | haste×2, night_vision×2 | — | — |
| 5 | 2 | — | slowness×2 | — | — |
| 6 | 8 | — | speed×2, 14×2, weakness×2 | — | charge×2 |
| 7 | 12 | — | speed×2, blindness×2, invisibility×2 | — | DeathCount×2, MatchStart×2 |
| 8 | 8 | spawn_egg×4 | — | — | Ender×4 |
| 9 | 3 | — | hunger×2, slowness×1 | — | — |
| 10 | 12 | — | slowness×4 | — | Timer×4 |
| 11 | 5 | — | slowness×3, 4×2 | — | — |
| 16 | 20 | — | clear×2 | — | sun×2 |
| 17 | 5 | — | 1×2, speed×2 | — | coldness×1 |
| 18 | 4 | — | — | — | coldness×4 |
| 19 | 4 | — | — | arrow×2, spectral_arrow×1 | coldness×1 |
| 20 | 8 | — | 25×2 | — | Lava×2 |
| 21 | 23 | — | 25×9, minecraft×2, slowness×1, weakness×1, wither×1 | arrow×2, spectral_arrow×1 | charge1×2, Hit×2 |
| 22 | 30 | — | 25×6, weakness×6, slowness×4, wither×4, blindness×4 | — | Hit×2 |
| 23 | 17 | — | 11×2, 14×2, slowness×1, weakness×1, wither×1 | parrot×2, armor_stand×1 | — |
| 24 | 25 | spawn_egg×2, iron_chestplate×2, wooden_sword×2, cooked_porkchop×2, iron_helmet×2 | regeneration×2, 11×2, blindness×1 | armor_stand×4 | Hit×2, KitNum×2 |
| 25 | 23 | spawn_egg×2, golden_chestplate×2, golden_sword×2, rotten_flesh×2 | 5×2, speed×2, 7×2, wither×2, glowing×2 | armor_stand×1 | KitNum×2 |
| 26 | 48 | arrow×2 | blindness×1 | arrow×40 | Hit×2, coldness×1 |
| 27 | 12 | cooked_porkchop×2 | — | wolf×2 | Dog×4, FreezeDog×2 |
| 28 | 3 | — | slowness×2 | — | coldness×1 |
| 29 | 26 | blaze_powder×4, spawn_egg×2 | clear×4, 11×2 | blaze×2 | thunder×4, charge×4, cd×2, Hit×2 |
| 30 | 20 | sugar×4, snowball×2 | slowness×2, 4×2 | — | charge×4, cd2×2, spider×2 |
| 31 | 47 | spawn_egg×4, gunpowder×4, cooked_beef×2, iron_chestplate×2, stone_sword×2, shield×2 | weakness×4, slowness×2, invisibility×2, 11×1 | — | hide×6, charge×4, cd3×2, Hit×2, KitNum×2 |
| 32 | 53 | dye×4, spawn_egg×2, stone_axe×2, chainmail_chestplate×2, chainmail_helmet×2, cooked_beef×2 | 1×4, haste×4, 5×2, night_vision×2, poison×2 | — | boost×6, charge×4, KitNum×2, Hitten×2, cd3×2 |
| 33 | 2 | — | 5×2 | — | — |
| 34 | 128 | mutton×6, beef×6, rabbit×6, porkchop×6, spider_eye×4, potion×4 | health_boost×12, regeneration×6, speed×2, night_vision×2, 5×2 | — | Hit×32, Head×2, LegMeat×2, ChewingMeat×2, Heart×2 |
| 35 | 92 | diamond_sword×8, iron_sword×6, bow×6, arrow×6, diamond_axe×6, stone_sword×6 | — | — | weapon×34 |
| 36 | 64 | tipped_arrow×30, spectral_arrow×2 | — | — | bow×32 |
| 39 | 8 | spawn_egg×2 | 25×4 | — | charge×2 |
| 40 | 54 | quartz×6, tripwire_hook×4, gunpowder×4, red_flower×2, dye×2, firework_charge×2 | glowing×2, 25×2, poison×2, mining_fatigue×2, slowness×2 | minecraft×2, creeper×2, silverfish×2 | TrapReset×4, charge×4, jump×2 |
| 41 | 16 | snowball×2 | instant_damage×4 | — | caster×4, casted×2 |
| 42 | 8 | — | 5×6, instant_damage×1 | — | — |
| 43 | 60 | spawn_egg×6, leather_boots×4, leather_chestplate×4 | 5×6, minecraft×2 | armor_stand×2 | line×10, fist×6, sweep×4, selve×4, Hit×2 |
| 44 | 30 | golden_carrot×2, diamond_sword×2, golden_leggings×2, diamond_helmet×2, spawn_egg×2, diamond_boots×2 | glowing×4, speed×4, instant_damage×2 | — | demass×4 |
| 45 | 28 | oak_stairs×4 | — | — | sit×2, seat×2, sitDetect×2, one×2, oneDetect×2 |
| 46 | 28 | — | minecraft×4, slowness×2, instant_health×2 | creeper×6 | zombieTimer×6, charge×2, Hit×2, zombieExplosive×2, Hitten×2 |
| 47 | 88 | leather_chestplate×6, skull×6, leather_leggings×6, leather_boots×6, spawn_egg×4, cooked_beef×2 | minecraft×6, wither×4, speed×2, weakness×2 | — | withercharge×6, witherspawn×6, witherlimit×6, witherhide×4, withering×4 |
| 48 | 38 | iron_helmet×4, diamond_chestplate×4, iron_leggings×4, iron_boots×4, spawn_egg×2 | instant_damage×2, glowing×2 | — | magicShieldlim×6, magicShield×4, magicShieldch×4, Hitten×2 |
| 49 | 14 | — | — | — | Hit×2, negotiate×2 |
| 50 | 34 | — | blindness×4, slowness×4, nausea×2, speed×2 | minecraft×6 | annoying×8, annoy×4, annoyChance×2, Hit×2 |
| 51 | 77 | spawn_egg×6 | speed×20, instant_damage×4, minecraft×4 | — | kill×2, charge×2, wheelchair×2, otto×2, Hit×2 |
| 52 | 42 | — | — | minecraft×8 | puppet×8, puppetBoost×4, DeathCount×2 |
| 53 | 13 | dye×4 | — | minecraft×2 | charge×2, DeathCount×1, KitNum×1 |
| 55 | 54 | spawn_egg×8 | minecraft×8 | minecraft×8 | direct×8, charge×6, explosionUse×4 |
| 56 | 32 | — | speed×8, minecraft×2, strength×2 | minecraft×2 | Hit×4, charge×4, Moved×2, dotcharge×2, Moved1×2 |
| 57 | 4 | spawn_egg×2 | minecraft×2 | — | — |
| 58 | 19 | air×4, rotten_flesh×2, cooked_beef×2 | minecraft×4, blindness×2 | — | KitNum×2, Hitten×2, transTimer×1 |
| 59 | 19 | pumpkin×2, diamond_chestplate×2, cooked_beef×2, rotten_flesh×2 | minecraft×6, blindness×2 | — | KitNum×2, transTimer×1 |
| 60 | 10 | clay_ball×4 | — | minecraft×2 | charge×2 |
| 61 | 88 | iron_ingot×8, flint×6, stick×4, wool×4, planks×4, gunpowder×4 | — | — | charge×2, mine×2 |
| 62 | 8 | wooden_sword×2, arrow×2 | 11×2, 14×2 | — | — |
| 63 | 14 | spawn_egg×2 | — | armor_stand×2 | toCome×4 |
| 64 | 4 | — | resistance×2 | — | invincible×2 |
| 65 | 26 | spawn_egg×2 | — | minecraft×8, creeper×4 | mobCd×2, mob×2, mobPos×2, mobExp×2, mobType×2 |
| 66 | 20 | fish×2 | minecraft×8 | creeper×2 | fly×4, walk×2, run×2 |
| 67 | 16 | spawn_egg×2 | — | horse×2 | horseCall×4, horseAlive×4 |
| 68 | 18 | — | hunger×4, weakness×2, slowness×2, mining_fatigue×2, speed×2 | — | Hit×2 |
| 69 | 8 | tipped_arrow×4, arrow×2 | — | — | reload×2 |
| 70 | 120 | spawn_egg×28, stick×6, shield×4, feather×4, bow×4, arrow×4 | resistance×4, speed×4, strength×2, invisibility×2, haste×2 | — | pzCooldown×20, hatTimer×6, pzSkill×2, haoStart×2, stepStart×2 |
