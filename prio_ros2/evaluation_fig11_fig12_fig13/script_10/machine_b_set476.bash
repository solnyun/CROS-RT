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
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_1 -p 49 -st topic476_0_0 -pt topic476_0_1 -u 0.009036097438141377 > ./result_10chains/node476_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_1 -p 216 -st topic476_1_0 -pt topic476_1_1 -u 0.009715977983352275 > ./result_10chains/node476_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_1 -p 297 -st topic476_2_0 -pt topic476_2_1 -u 8.121264564503461e-05 > ./result_10chains/node476_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_1 -p 350 -st topic476_3_0 -pt topic476_3_1 -u 0.04118192335513593 > ./result_10chains/node476_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_1 -p 372 -st topic476_4_0 -pt topic476_4_1 -u 0.005877041274253814 > ./result_10chains/node476_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_1 -p 408 -st topic476_5_0 -pt topic476_5_1 -u 0.02599078210001246 > ./result_10chains/node476_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_6_1 -p 593 -st topic476_6_0 -pt topic476_6_1 -u 0.001519016952948149 > ./result_10chains/node476_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_7_1 -p 639 -st topic476_7_0 -pt topic476_7_1 -u 0.04924748807261273 > ./result_10chains/node476_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_8_1 -p 774 -st topic476_8_0 -pt topic476_8_1 -u 0.01601760046212132 > ./result_10chains/node476_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_9_1 -p 952 -st topic476_9_0 -pt topic476_9_1 -u 0.017911935900791855 > ./result_10chains/node476_9_1.txt &
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
    "./result_10chains/node476_0_1.txt 90"
    "./result_10chains/node476_1_1.txt 89"
    "./result_10chains/node476_2_1.txt 88"
    "./result_10chains/node476_3_1.txt 87"
    "./result_10chains/node476_4_1.txt 86"
    "./result_10chains/node476_5_1.txt 85"
    "./result_10chains/node476_6_1.txt 84"
    "./result_10chains/node476_7_1.txt 83"
    "./result_10chains/node476_8_1.txt 82"
    "./result_10chains/node476_9_1.txt 81"
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
