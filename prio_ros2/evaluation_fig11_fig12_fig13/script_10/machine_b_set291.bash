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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_1 -p 80 -st topic291_0_0 -pt topic291_0_1 -u 0.04209312247827346 > ./result_10chains/node291_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_1 -p 314 -st topic291_1_0 -pt topic291_1_1 -u 0.04468467025424916 > ./result_10chains/node291_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_1 -p 377 -st topic291_2_0 -pt topic291_2_1 -u 0.02081655097993701 > ./result_10chains/node291_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_1 -p 511 -st topic291_3_0 -pt topic291_3_1 -u 0.009943795352360563 > ./result_10chains/node291_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_1 -p 520 -st topic291_4_0 -pt topic291_4_1 -u 0.002989510717141597 > ./result_10chains/node291_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_1 -p 616 -st topic291_5_0 -pt topic291_5_1 -u 0.003282264736534174 > ./result_10chains/node291_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_1 -p 726 -st topic291_6_0 -pt topic291_6_1 -u 0.011660996303234639 > ./result_10chains/node291_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_1 -p 810 -st topic291_7_0 -pt topic291_7_1 -u 0.0015525696817019763 > ./result_10chains/node291_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_8_1 -p 816 -st topic291_8_0 -pt topic291_8_1 -u 0.007873661703009655 > ./result_10chains/node291_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_9_1 -p 982 -st topic291_9_0 -pt topic291_9_1 -u 0.0035640385795407126 > ./result_10chains/node291_9_1.txt &
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
    "./result_10chains/node291_0_1.txt 90"
    "./result_10chains/node291_1_1.txt 89"
    "./result_10chains/node291_2_1.txt 88"
    "./result_10chains/node291_3_1.txt 87"
    "./result_10chains/node291_4_1.txt 86"
    "./result_10chains/node291_5_1.txt 85"
    "./result_10chains/node291_6_1.txt 84"
    "./result_10chains/node291_7_1.txt 83"
    "./result_10chains/node291_8_1.txt 82"
    "./result_10chains/node291_9_1.txt 81"
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
