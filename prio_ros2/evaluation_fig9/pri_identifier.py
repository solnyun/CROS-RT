import sys
import os
import psutil
import ctypes
import re

SYS_my_syscall = 457

# 인자 개수 확인
if len(sys.argv) != 3:
    print("Usage: python3 pri_identifier.py <file_path> <priority> <cpu>")
    sys.exit(1)

file_path = sys.argv[1]
priority = sys.argv[2]

libc = ctypes.CDLL(None)
libc.syscall.argtypes = [ctypes.c_int, ctypes.c_int]
libc.syscall.restype = ctypes.c_long

# 파일 열기 및 읽기
with open(file_path, "r") as f:
    print(file_path)
    lines = f.read().splitlines()

for line in lines[:15]:  # 처음 15개 라인만 처리
    parts = line.split()  # 공백으로 문자열 분리

    if "Thread:" in line:
        thread_index = parts.index("Thread:") + 1
        if thread_index < len(parts):
            tid = int(parts[thread_index])
            if priority != "100":
                command = f"sudo chrt -f -p {priority} {tid}"
                os.system(command)
                print(command)


    if "port:" in line:
        port_index = parts.index("port:") + 1
        try:
            if port_index < len(parts):
                port = int(parts[port_index])
                libc.syscall(SYS_my_syscall, int(priority), port)
                #print(f"Set priority-port: {port}")
        except ValueError:
            # ValueError 예외가 발생하면 무시하고 계속 진행
            print("ValueError caught for port, skipping to next line.")

