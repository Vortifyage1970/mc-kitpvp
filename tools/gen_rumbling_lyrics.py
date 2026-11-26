#!/usr/bin/env python3
"""生成 Rumbling 的歌词时间点（照雨爱的写法：schedule 串联 + tellraw）。

改 LINES 里的 (秒, 英文歌词) 后重跑：

    .\.venv\Scripts\python.exe tools\gen_rumbling_lyrics.py

它会把 ev_*.mcfunction / start.mcfunction / stop.mcfunction 写进
存档里的 rumbling 数据包（namespace kitpvp / music/rumbling_lyric）。
地鸣开始时调用 kitpvp:music/rumbling_lyric/start，巨人驾驶员死亡时调用 /stop。
"""
import json, os

ROOT = os.path.join(os.environ.get("DSH_RUMBLING_PACK",
    r"D:\Minecraft\.minecraft\versions\1.20.1-Forge_47.4.4\saves\职业战争\datapacks\rumbling"),
    "data", "kitpvp", "functions", "music", "rumbling_lyric")

# (秒, 歌词) —— 按完整版主段估的时间，听一遍后改这里重跑
LINES = [
    (0.0, "Rumbling rumbling"),
    (2.2, "It's coming"),
    (3.2, "Rumbling rumbling"),
    (6.5, "Beware"),
    (13.0, "Coming for you"),
    (20.0, "All I ever wanted to do was do right things"),
    (23.5, "I never wanted to be the king"),
    (26.0, "I swear"),
    (30.0, "All I ever wanted to do was save your life"),
    (33.0, "I never wanted to grab a knife"),
    (36.0, "I swear"),
    (40.0, "Tearless fearless"),
    (44.0, "Burning burning"),
    (47.0, "You tell me what have I missed"),
    (50.0, "Still wandering in the deep mist"),
    (56.0, "If I lose it all slip and fall"),
    (60.0, "I will never look away"),
    (63.0, "If I lose it all lose it all lose it all"),
    (70.0, "If I lose it all outside the wall"),
    (73.0, "Live to die another day"),
    (76.0, "I don't want anything"),
    (78.0, "I'm just here to..."),
    (83.0, "Beware"),
]

def main():
    os.makedirs(ROOT, exist_ok=True)
    names = [f"ev_{i:03d}" for i in range(len(LINES))]
    for i, (sec, text) in enumerate(LINES):
        body = ["tellraw @a " + json.dumps({"text": "♪ " + text + " ♪", "color": "light_purple", "bold": True},
                                            ensure_ascii=False)]
        if i + 1 < len(LINES):
            body.append("schedule function kitpvp:music/rumbling_lyric/%s %dt replace" % (names[i + 1], int(round((LINES[i + 1][0] - sec) * 20))))
        open(os.path.join(ROOT, names[i] + ".mcfunction"), "w", encoding="utf-8", newline="\n").write("\n".join(body) + "\n")
    open(os.path.join(ROOT, "start.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        "# 从第一句的秒数开始排\nschedule function kitpvp:music/rumbling_lyric/%s 1t replace\n" % names[0])
    stop = ["# 停止歌词：清掉链上所有还没发射的 schedule"] + [f"schedule clear kitpvp:music/rumbling_lyric/{n}" for n in names]
    open(os.path.join(ROOT, "stop.mcfunction"), "w", encoding="utf-8", newline="\n").write("\n".join(stop) + "\n")
    print("歌词函数写入:", ROOT, len(names), "句")

if __name__ == "__main__":
    main()
