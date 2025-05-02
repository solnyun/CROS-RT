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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_2 -p 100 -st topic42_0_1 -pt None -u 0.028056475064611563 > ./result_8chains/node42_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_2 -p 219 -st topic42_1_1 -pt None -u 0.02189361060956385 > ./result_8chains/node42_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_2 -p 232 -st topic42_2_1 -pt None -u 0.006115360972945183 > ./result_8chains/node42_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_2 -p 501 -st topic42_3_1 -pt None -u 0.0442595812419887 > ./result_8chains/node42_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_2 -p 507 -st topic42_4_1 -pt None -u 0.011006656287710359 > ./result_8chains/node42_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_2 -p 680 -st topic42_5_1 -pt None -u 0.004124597927323309 > ./result_8chains/node42_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_2 -p 894 -st topic42_6_1 -pt None -u 0.004417503801639203 > ./result_8chains/node42_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_2 -p 967 -st topic42_7_1 -pt None -u 0.013333479271208183 > ./result_8chains/node42_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_0 -p 100 -st none -pt topic42_0_0 -u 0.019272466425145518 > ./result_8chains/node42_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_0 -p 219 -st none -pt topic42_1_0 -u 0.04931599443304985 > ./result_8chains/node42_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_0 -p 232 -st none -pt topic42_2_0 -u 0.007038318650369135 > ./result_8chains/node42_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_0 -p 501 -st none -pt topic42_3_0 -u 0.001313141778635063 > ./result_8chains/node42_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_0 -p 507 -st none -pt topic42_4_0 -u 0.008826720754750161 > ./result_8chains/node42_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_0 -p 680 -st none -pt topic42_5_0 -u 0.00010161137701311662 > ./result_8chains/node42_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_6_0 -p 894 -st none -pt topic42_6_0 -u 0.044603276473882944 > ./result_8chains/node42_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_7_0 -p 967 -st none -pt topic42_7_0 -u 0.01207695725647917 > ./result_8chains/node42_7_0.txt &
sleep 10
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
    "./result_8chains/node42_0_0.txt 90"
    "./result_8chains/node42_0_2.txt 90"
    "./result_8chains/node42_1_0.txt 89"
    "./result_8chains/node42_1_2.txt 89"
    "./result_8chains/node42_2_0.txt 88"
    "./result_8chains/node42_2_2.txt 88"
    "./result_8chains/node42_3_0.txt 87"
    "./result_8chains/node42_3_2.txt 87"
    "./result_8chains/node42_4_0.txt 86"
    "./result_8chains/node42_4_2.txt 86"
    "./result_8chains/node42_5_0.txt 85"
    "./result_8chains/node42_5_2.txt 85"
    "./result_8chains/node42_6_0.txt 84"
    "./result_8chains/node42_6_2.txt 84"
    "./result_8chains/node42_7_0.txt 83"
    "./result_8chains/node42_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
