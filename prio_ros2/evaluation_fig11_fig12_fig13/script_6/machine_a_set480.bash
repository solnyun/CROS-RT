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
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_2 -p 67 -st topic480_0_1 -pt None -u 0.043078518934459686 > ./result_6chains/node480_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_2 -p 281 -st topic480_1_1 -pt None -u 0.009441316435127745 > ./result_6chains/node480_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_2 -p 296 -st topic480_2_1 -pt None -u 0.024492184110350063 > ./result_6chains/node480_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_2 -p 339 -st topic480_3_1 -pt None -u 0.10643357193686886 > ./result_6chains/node480_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_2 -p 615 -st topic480_4_1 -pt None -u 0.0053935701106020625 > ./result_6chains/node480_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_2 -p 716 -st topic480_5_1 -pt None -u 0.011509492436086637 > ./result_6chains/node480_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_0 -p 67 -st none -pt topic480_0_0 -u 0.00949778999774148 > ./result_6chains/node480_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_0 -p 281 -st none -pt topic480_1_0 -u 0.013934985145916956 > ./result_6chains/node480_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_0 -p 296 -st none -pt topic480_2_0 -u 0.057210404086737165 > ./result_6chains/node480_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_0 -p 339 -st none -pt topic480_3_0 -u 0.006799172993797287 > ./result_6chains/node480_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_0 -p 615 -st none -pt topic480_4_0 -u 0.005905105773546027 > ./result_6chains/node480_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_0 -p 716 -st none -pt topic480_5_0 -u 0.023423846472947207 > ./result_6chains/node480_5_0.txt &
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
    "./result_6chains/node480_0_0.txt 90"
    "./result_6chains/node480_0_2.txt 90"
    "./result_6chains/node480_1_0.txt 89"
    "./result_6chains/node480_1_2.txt 89"
    "./result_6chains/node480_2_0.txt 88"
    "./result_6chains/node480_2_2.txt 88"
    "./result_6chains/node480_3_0.txt 87"
    "./result_6chains/node480_3_2.txt 87"
    "./result_6chains/node480_4_0.txt 86"
    "./result_6chains/node480_4_2.txt 86"
    "./result_6chains/node480_5_0.txt 85"
    "./result_6chains/node480_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
