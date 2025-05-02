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
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_1 -p 94 -st topic145_0_0 -pt topic145_0_1 -u 0.00609218625029162 > ./result_8chains/node145_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_1 -p 173 -st topic145_1_0 -pt topic145_1_1 -u 0.0007264644863924086 > ./result_8chains/node145_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_1 -p 307 -st topic145_2_0 -pt topic145_2_1 -u 0.0036764484026528543 > ./result_8chains/node145_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_1 -p 318 -st topic145_3_0 -pt topic145_3_1 -u 0.019522529113105924 > ./result_8chains/node145_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_1 -p 440 -st topic145_4_0 -pt topic145_4_1 -u 0.008740240662766241 > ./result_8chains/node145_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_1 -p 513 -st topic145_5_0 -pt topic145_5_1 -u 0.05909628080908813 > ./result_8chains/node145_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_1 -p 609 -st topic145_6_0 -pt topic145_6_1 -u 0.04484131114097534 > ./result_8chains/node145_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_1 -p 790 -st topic145_7_0 -pt topic145_7_1 -u 0.06569470629940286 > ./result_8chains/node145_7_1.txt &
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
    "./result_8chains/node145_0_1.txt 90"
    "./result_8chains/node145_1_1.txt 89"
    "./result_8chains/node145_2_1.txt 88"
    "./result_8chains/node145_3_1.txt 87"
    "./result_8chains/node145_4_1.txt 86"
    "./result_8chains/node145_5_1.txt 85"
    "./result_8chains/node145_6_1.txt 84"
    "./result_8chains/node145_7_1.txt 83"
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
