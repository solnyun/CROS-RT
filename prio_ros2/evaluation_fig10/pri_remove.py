import sys
import os
import psutil
import ctypes

SYS_my_syscall = 458

k = sys.argv[1]

libc = ctypes.CDLL(None)
libc.syscall.argtypes = [ctypes.c_int, ctypes. c_int]
libc.syscall.restype = ctypes.c_long

file_name = k
f = open(file_name, "r")
print(file_name)
sub = f.read().splitlines()

for r in range(len(sub)):
    parts = sub[r].split()  # 공백으로 문자열 분리

    if "port:" in sub[r]:
        port_index = parts.index("port:") + 1  # "port:" 다음 인덱스 찾기
        if port_index < len(parts):
            port = int(parts[port_index])  # 추출한 인덱스의 숫자 변환
            result = libc.syscall(SYS_my_syscall, port)
            print("remove priority-port:", port)



f.close()
