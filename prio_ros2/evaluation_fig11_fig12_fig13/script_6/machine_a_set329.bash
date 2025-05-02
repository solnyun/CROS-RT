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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_2 -p 77 -st topic329_0_1 -pt None -u 0.0006700901372453938 > ./result_6chains/node329_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_2 -p 628 -st topic329_1_1 -pt None -u 0.03646903599736273 > ./result_6chains/node329_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_2 -p 633 -st topic329_2_1 -pt None -u 0.0056220405593697675 > ./result_6chains/node329_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_2 -p 636 -st topic329_3_1 -pt None -u 0.01163115417966648 > ./result_6chains/node329_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_2 -p 783 -st topic329_4_1 -pt None -u 0.019441209763894685 > ./result_6chains/node329_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_2 -p 894 -st topic329_5_1 -pt None -u 0.020088458311513957 > ./result_6chains/node329_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_0 -p 77 -st none -pt topic329_0_0 -u 0.023842949121508694 > ./result_6chains/node329_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_0 -p 628 -st none -pt topic329_1_0 -u 0.0069327618622542775 > ./result_6chains/node329_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_0 -p 633 -st none -pt topic329_2_0 -u 0.007915231807124501 > ./result_6chains/node329_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_0 -p 636 -st none -pt topic329_3_0 -u 0.09584943234177573 > ./result_6chains/node329_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_4_0 -p 783 -st none -pt topic329_4_0 -u 0.061648910664748896 > ./result_6chains/node329_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_5_0 -p 894 -st none -pt topic329_5_0 -u 0.013170485022778636 > ./result_6chains/node329_5_0.txt &
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
    "./result_6chains/node329_0_0.txt 90"
    "./result_6chains/node329_0_2.txt 90"
    "./result_6chains/node329_1_0.txt 89"
    "./result_6chains/node329_1_2.txt 89"
    "./result_6chains/node329_2_0.txt 88"
    "./result_6chains/node329_2_2.txt 88"
    "./result_6chains/node329_3_0.txt 87"
    "./result_6chains/node329_3_2.txt 87"
    "./result_6chains/node329_4_0.txt 86"
    "./result_6chains/node329_4_2.txt 86"
    "./result_6chains/node329_5_0.txt 85"
    "./result_6chains/node329_5_2.txt 85"
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
