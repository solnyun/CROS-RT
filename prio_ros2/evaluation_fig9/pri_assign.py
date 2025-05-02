import sys
import os
import psutil

k = sys.argv[1]
pri = sys.argv[2]
#cpu = int(sys.argv[3])

file_name = k
f = open(file_name, "r")
print(file_name)
sub = f.read().splitlines()
#cpu = 0

for r in range(10):
    if "pub" in sub[r]:
        print(sub[r])
        #cpu = 1
    elif "Thread:" in sub[r]:
        tid = int(sub[r].split(" ")[2])
        command = "sudo chrt -f -p " + pri + " " + str(tid)
        print(command, sub[r].split(" "))

        #p = psutil.Process(tid)
        #p.cpu_affinity([cpu])

        os.system(command)

f.close()
