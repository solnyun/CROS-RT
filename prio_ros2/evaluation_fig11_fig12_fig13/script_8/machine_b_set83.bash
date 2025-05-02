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
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_1 -p 13 -st topic83_0_0 -pt topic83_0_1 -u 0.036647557828364874 > ./result_8chains/node83_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_1 -p 242 -st topic83_1_0 -pt topic83_1_1 -u 0.028359118639710024 > ./result_8chains/node83_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_1 -p 415 -st topic83_2_0 -pt topic83_2_1 -u 0.01831920239436996 > ./result_8chains/node83_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_1 -p 466 -st topic83_3_0 -pt topic83_3_1 -u 0.014822884670696646 > ./result_8chains/node83_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_1 -p 471 -st topic83_4_0 -pt topic83_4_1 -u 0.004201821929862903 > ./result_8chains/node83_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_1 -p 529 -st topic83_5_0 -pt topic83_5_1 -u 0.03647774514697419 > ./result_8chains/node83_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_1 -p 826 -st topic83_6_0 -pt topic83_6_1 -u 0.0033766998322668634 > ./result_8chains/node83_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_1 -p 875 -st topic83_7_0 -pt topic83_7_1 -u 0.027296661152240522 > ./result_8chains/node83_7_1.txt &
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
    "./result_8chains/node83_0_1.txt 90"
    "./result_8chains/node83_1_1.txt 89"
    "./result_8chains/node83_2_1.txt 88"
    "./result_8chains/node83_3_1.txt 87"
    "./result_8chains/node83_4_1.txt 86"
    "./result_8chains/node83_5_1.txt 85"
    "./result_8chains/node83_6_1.txt 84"
    "./result_8chains/node83_7_1.txt 83"
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
