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
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_1 -p 51 -st topic279_0_0 -pt topic279_0_1 -u 0.013834232084920461 > ./result_10chains/node279_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_1 -p 158 -st topic279_1_0 -pt topic279_1_1 -u 0.0004889168062028326 > ./result_10chains/node279_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_1 -p 483 -st topic279_2_0 -pt topic279_2_1 -u 0.017858996532044313 > ./result_10chains/node279_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_1 -p 518 -st topic279_3_0 -pt topic279_3_1 -u 0.031724340098800874 > ./result_10chains/node279_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_1 -p 554 -st topic279_4_0 -pt topic279_4_1 -u 0.015571636192853788 > ./result_10chains/node279_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_1 -p 764 -st topic279_5_0 -pt topic279_5_1 -u 0.10463963932549353 > ./result_10chains/node279_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_6_1 -p 775 -st topic279_6_0 -pt topic279_6_1 -u 0.002501215806487031 > ./result_10chains/node279_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_7_1 -p 863 -st topic279_7_0 -pt topic279_7_1 -u 0.00928753764476832 > ./result_10chains/node279_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_8_1 -p 894 -st topic279_8_0 -pt topic279_8_1 -u 0.009468450178418138 > ./result_10chains/node279_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_9_1 -p 931 -st topic279_9_0 -pt topic279_9_1 -u 0.015364147074522692 > ./result_10chains/node279_9_1.txt &
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
    "./result_10chains/node279_0_1.txt 90"
    "./result_10chains/node279_1_1.txt 89"
    "./result_10chains/node279_2_1.txt 88"
    "./result_10chains/node279_3_1.txt 87"
    "./result_10chains/node279_4_1.txt 86"
    "./result_10chains/node279_5_1.txt 85"
    "./result_10chains/node279_6_1.txt 84"
    "./result_10chains/node279_7_1.txt 83"
    "./result_10chains/node279_8_1.txt 82"
    "./result_10chains/node279_9_1.txt 81"
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
