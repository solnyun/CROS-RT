#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_2 -p 20 -st topic344_0_1 -pt None -u 0.0013065177177740694 > ./result_10chains/node344_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_2 -p 61 -st topic344_1_1 -pt None -u 0.016125376210878284 > ./result_10chains/node344_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_2 -p 117 -st topic344_2_1 -pt None -u 0.003310867658575023 > ./result_10chains/node344_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_2 -p 179 -st topic344_3_1 -pt None -u 0.02907313519138227 > ./result_10chains/node344_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_2 -p 323 -st topic344_4_1 -pt None -u 0.002272683797050201 > ./result_10chains/node344_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_2 -p 835 -st topic344_5_1 -pt None -u 0.0345981103223737 > ./result_10chains/node344_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_2 -p 901 -st topic344_6_1 -pt None -u 0.027293704489952497 > ./result_10chains/node344_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_2 -p 914 -st topic344_7_1 -pt None -u 0.03704107227873027 > ./result_10chains/node344_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_8_2 -p 949 -st topic344_8_1 -pt None -u 0.012658424016828512 > ./result_10chains/node344_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_9_2 -p 970 -st topic344_9_1 -pt None -u 0.0205330439266057 > ./result_10chains/node344_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_0 -p 20 -st none -pt topic344_0_0 -u 0.007571772847464575 > ./result_10chains/node344_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_0 -p 61 -st none -pt topic344_1_0 -u 0.004696374430825101 > ./result_10chains/node344_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_0 -p 117 -st none -pt topic344_2_0 -u 0.03994124195702359 > ./result_10chains/node344_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_0 -p 179 -st none -pt topic344_3_0 -u 0.014626345319614431 > ./result_10chains/node344_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_0 -p 323 -st none -pt topic344_4_0 -u 0.010785257915565727 > ./result_10chains/node344_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_0 -p 835 -st none -pt topic344_5_0 -u 0.02955771238133048 > ./result_10chains/node344_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_0 -p 901 -st none -pt topic344_6_0 -u 0.0017345460789113532 > ./result_10chains/node344_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_0 -p 914 -st none -pt topic344_7_0 -u 0.01026638981052716 > ./result_10chains/node344_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_8_0 -p 949 -st none -pt topic344_8_0 -u 0.06306634502551689 > ./result_10chains/node344_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_9_0 -p 970 -st none -pt topic344_9_0 -u 0.008704421589060166 > ./result_10chains/node344_9_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_10chains/node344_0_0.txt 90"
    "./result_10chains/node344_0_2.txt 90"
    "./result_10chains/node344_1_0.txt 89"
    "./result_10chains/node344_1_2.txt 89"
    "./result_10chains/node344_2_0.txt 88"
    "./result_10chains/node344_2_2.txt 88"
    "./result_10chains/node344_3_0.txt 87"
    "./result_10chains/node344_3_2.txt 87"
    "./result_10chains/node344_4_0.txt 86"
    "./result_10chains/node344_4_2.txt 86"
    "./result_10chains/node344_5_0.txt 85"
    "./result_10chains/node344_5_2.txt 85"
    "./result_10chains/node344_6_0.txt 84"
    "./result_10chains/node344_6_2.txt 84"
    "./result_10chains/node344_7_0.txt 83"
    "./result_10chains/node344_7_2.txt 83"
    "./result_10chains/node344_8_0.txt 82"
    "./result_10chains/node344_8_2.txt 82"
    "./result_10chains/node344_9_0.txt 81"
    "./result_10chains/node344_9_2.txt 81"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
