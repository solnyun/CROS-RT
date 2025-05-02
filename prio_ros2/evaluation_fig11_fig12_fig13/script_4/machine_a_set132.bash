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
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_2 -p 405 -st topic132_0_1 -pt None -u 0.039688106701432524 > ./result_4chains/node132_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_2 -p 512 -st topic132_1_1 -pt None -u 0.055422389682557915 > ./result_4chains/node132_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_2 -p 547 -st topic132_2_1 -pt None -u 0.007109549940124221 > ./result_4chains/node132_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_2 -p 576 -st topic132_3_1 -pt None -u 0.043316799564752546 > ./result_4chains/node132_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_0 -p 405 -st none -pt topic132_0_0 -u 0.01682142136569248 > ./result_4chains/node132_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_0 -p 512 -st none -pt topic132_1_0 -u 0.01702260228604041 > ./result_4chains/node132_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_0 -p 547 -st none -pt topic132_2_0 -u 0.04995150061526943 > ./result_4chains/node132_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_0 -p 576 -st none -pt topic132_3_0 -u 0.10026759528256024 > ./result_4chains/node132_3_0.txt &
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
    "./result_4chains/node132_0_0.txt 90"
    "./result_4chains/node132_0_2.txt 90"
    "./result_4chains/node132_1_0.txt 89"
    "./result_4chains/node132_1_2.txt 89"
    "./result_4chains/node132_2_0.txt 88"
    "./result_4chains/node132_2_2.txt 88"
    "./result_4chains/node132_3_0.txt 87"
    "./result_4chains/node132_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
