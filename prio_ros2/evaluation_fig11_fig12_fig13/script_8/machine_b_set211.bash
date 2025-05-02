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
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_1 -p 318 -st topic211_0_0 -pt topic211_0_1 -u 0.02564872324157924 > ./result_8chains/node211_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_1 -p 330 -st topic211_1_0 -pt topic211_1_1 -u 0.008323744321236726 > ./result_8chains/node211_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_1 -p 598 -st topic211_2_0 -pt topic211_2_1 -u 0.01411906977897781 > ./result_8chains/node211_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_1 -p 697 -st topic211_3_0 -pt topic211_3_1 -u 0.012093614000260405 > ./result_8chains/node211_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_1 -p 747 -st topic211_4_0 -pt topic211_4_1 -u 0.0018618459585897085 > ./result_8chains/node211_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_1 -p 823 -st topic211_5_0 -pt topic211_5_1 -u 0.007826577495268633 > ./result_8chains/node211_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_6_1 -p 985 -st topic211_6_0 -pt topic211_6_1 -u 0.012872703336220634 > ./result_8chains/node211_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_7_1 -p 999 -st topic211_7_0 -pt topic211_7_1 -u 0.013176665320820414 > ./result_8chains/node211_7_1.txt &
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
    "./result_8chains/node211_0_1.txt 90"
    "./result_8chains/node211_1_1.txt 89"
    "./result_8chains/node211_2_1.txt 88"
    "./result_8chains/node211_3_1.txt 87"
    "./result_8chains/node211_4_1.txt 86"
    "./result_8chains/node211_5_1.txt 85"
    "./result_8chains/node211_6_1.txt 84"
    "./result_8chains/node211_7_1.txt 83"
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
