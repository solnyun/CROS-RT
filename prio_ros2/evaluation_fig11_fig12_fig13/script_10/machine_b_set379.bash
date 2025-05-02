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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_1 -p 18 -st topic379_0_0 -pt topic379_0_1 -u 0.003036602955328982 > ./result_10chains/node379_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_1 -p 134 -st topic379_1_0 -pt topic379_1_1 -u 0.012931186797964733 > ./result_10chains/node379_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_1 -p 228 -st topic379_2_0 -pt topic379_2_1 -u 0.039826957580178346 > ./result_10chains/node379_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_1 -p 475 -st topic379_3_0 -pt topic379_3_1 -u 0.04089698629079175 > ./result_10chains/node379_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_1 -p 502 -st topic379_4_0 -pt topic379_4_1 -u 0.017413576233745287 > ./result_10chains/node379_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_1 -p 632 -st topic379_5_0 -pt topic379_5_1 -u 0.01910015504690868 > ./result_10chains/node379_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_1 -p 714 -st topic379_6_0 -pt topic379_6_1 -u 0.01012001551159869 > ./result_10chains/node379_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_1 -p 774 -st topic379_7_0 -pt topic379_7_1 -u 0.008437804280241962 > ./result_10chains/node379_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_8_1 -p 838 -st topic379_8_0 -pt topic379_8_1 -u 0.010943211197576547 > ./result_10chains/node379_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_9_1 -p 897 -st topic379_9_0 -pt topic379_9_1 -u 0.027814446502795957 > ./result_10chains/node379_9_1.txt &
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
    "./result_10chains/node379_0_1.txt 90"
    "./result_10chains/node379_1_1.txt 89"
    "./result_10chains/node379_2_1.txt 88"
    "./result_10chains/node379_3_1.txt 87"
    "./result_10chains/node379_4_1.txt 86"
    "./result_10chains/node379_5_1.txt 85"
    "./result_10chains/node379_6_1.txt 84"
    "./result_10chains/node379_7_1.txt 83"
    "./result_10chains/node379_8_1.txt 82"
    "./result_10chains/node379_9_1.txt 81"
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
