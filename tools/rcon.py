#!/usr/bin/env python3
"""极简 RCON 客户端：把命令发给本地测试服，打印回包。

用法：
    python tools/rcon.py "reload" "function kitpvp:load"

连接参数可用环境变量覆盖（默认连本地测试服 127.0.0.1:25578 / testpw）：
    MC_RCON_HOST  MC_RCON_PORT  MC_RCON_PASS
"""
from __future__ import annotations

import os
import socket
import struct
import sys


def pack(req_id: int, cmd_type: int, body: str) -> bytes:
    data = struct.pack("<ii", req_id, cmd_type) + body.encode("utf-8") + b"\x00\x00"
    return struct.pack("<i", len(data)) + data


def recv(sock: socket.socket) -> tuple[int, int, str]:
    raw_len = sock.recv(4)
    if len(raw_len) < 4:
        raise ConnectionError("短包")
    (length,) = struct.unpack("<i", raw_len)
    payload = b""
    while len(payload) < length:
        chunk = sock.recv(length - len(payload))
        if not chunk:
            raise ConnectionError("断开")
        payload += chunk
    req_id, cmd_type = struct.unpack("<ii", payload[:8])
    return req_id, cmd_type, payload[8:-2].decode("utf-8", "replace")


def run(cmds: list[str],
        host: str | None = None,
        port: int | None = None,
        password: str | None = None) -> list[str]:
    host = host or os.environ.get("MC_RCON_HOST", "127.0.0.1")
    port = port or int(os.environ.get("MC_RCON_PORT", "25578"))
    password = password or os.environ.get("MC_RCON_PASS", "testpw")
    out: list[str] = []
    with socket.create_connection((host, port), timeout=10) as sock:
        sock.sendall(pack(1, 3, password))
        rid, _t, _b = recv(sock)
        if rid == -1:
            raise PermissionError("RCON 密码错误")
        for cmd in cmds:
            sock.sendall(pack(2, 2, cmd))
            _rid, _t, body = recv(sock)
            out.append(f"> {cmd}\n{body}")
    return out


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    try:
        for line in run(sys.argv[1:]):
            print(line)
    except OSError as exc:
        print("连不上 RCON（测试服没开？）：%s" % exc, file=sys.stderr)
        sys.exit(1)
