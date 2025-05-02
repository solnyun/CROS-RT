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
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_2 -p 253 -st topic369_0_1 -pt None -u 0.00960266077524996 > ./result_6chains/node369_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_2 -p 509 -st topic369_1_1 -pt None -u 0.001776949945501427 > ./result_6chains/node369_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_2 -p 559 -st topic369_2_1 -pt None -u 0.01857947353517278 > ./result_6chains/node369_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_2 -p 871 -st topic369_3_1 -pt None -u 0.001680600817817346 > ./result_6chains/node369_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_2 -p 895 -st topic369_4_1 -pt None -u 0.013014909599845526 > ./result_6chains/node369_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_2 -p 907 -st topic369_5_1 -pt None -u 0.01988428275830167 > ./result_6chains/node369_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_0 -p 253 -st none -pt topic369_0_0 -u 0.009360833538607394 > ./result_6chains/node369_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_0 -p 509 -st none -pt topic369_1_0 -u 0.008731198214222191 > ./result_6chains/node369_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_0 -p 559 -st none -pt topic369_2_0 -u 0.033727169212933394 > ./result_6chains/node369_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_0 -p 871 -st none -pt topic369_3_0 -u 0.02767904093898066 > ./result_6chains/node369_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_0 -p 895 -st none -pt topic369_4_0 -u 0.017545422682211376 > ./result_6chains/node369_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_0 -p 907 -st none -pt topic369_5_0 -u 0.003255921640882481 > ./result_6chains/node369_5_0.txt &
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
    "./result_6chains/node369_0_0.txt 90"
    "./result_6chains/node369_0_2.txt 90"
    "./result_6chains/node369_1_0.txt 89"
    "./result_6chains/node369_1_2.txt 89"
    "./result_6chains/node369_2_0.txt 88"
    "./result_6chains/node369_2_2.txt 88"
    "./result_6chains/node369_3_0.txt 87"
    "./result_6chains/node369_3_2.txt 87"
    "./result_6chains/node369_4_0.txt 86"
    "./result_6chains/node369_4_2.txt 86"
    "./result_6chains/node369_5_0.txt 85"
    "./result_6chains/node369_5_2.txt 85"
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
