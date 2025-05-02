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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_1 -p 159 -st topic426_0_0 -pt topic426_0_1 -u 0.006144583204855669 > ./result_10chains/node426_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_1 -p 207 -st topic426_1_0 -pt topic426_1_1 -u 0.001758860005581675 > ./result_10chains/node426_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_1 -p 231 -st topic426_2_0 -pt topic426_2_1 -u 0.03759495514812883 > ./result_10chains/node426_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_1 -p 242 -st topic426_3_0 -pt topic426_3_1 -u 0.005369478416751117 > ./result_10chains/node426_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_1 -p 481 -st topic426_4_0 -pt topic426_4_1 -u 0.000575871798107086 > ./result_10chains/node426_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_1 -p 645 -st topic426_5_0 -pt topic426_5_1 -u 0.029123248694658793 > ./result_10chains/node426_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_1 -p 764 -st topic426_6_0 -pt topic426_6_1 -u 0.030604001857167024 > ./result_10chains/node426_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_1 -p 810 -st topic426_7_0 -pt topic426_7_1 -u 0.008940174639774423 > ./result_10chains/node426_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_8_1 -p 943 -st topic426_8_0 -pt topic426_8_1 -u 0.016282355255425977 > ./result_10chains/node426_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_9_1 -p 986 -st topic426_9_0 -pt topic426_9_1 -u 0.0031771534863839768 > ./result_10chains/node426_9_1.txt &
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
    "./result_10chains/node426_0_1.txt 90"
    "./result_10chains/node426_1_1.txt 89"
    "./result_10chains/node426_2_1.txt 88"
    "./result_10chains/node426_3_1.txt 87"
    "./result_10chains/node426_4_1.txt 86"
    "./result_10chains/node426_5_1.txt 85"
    "./result_10chains/node426_6_1.txt 84"
    "./result_10chains/node426_7_1.txt 83"
    "./result_10chains/node426_8_1.txt 82"
    "./result_10chains/node426_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
