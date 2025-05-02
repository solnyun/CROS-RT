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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_2 -p 409 -st topic212_0_1 -pt None -u 0.04126371488683922 > ./result_4chains/node212_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_2 -p 840 -st topic212_1_1 -pt None -u 0.013537103204178003 > ./result_4chains/node212_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_2 -p 873 -st topic212_2_1 -pt None -u 0.06603141089910865 > ./result_4chains/node212_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_2 -p 948 -st topic212_3_1 -pt None -u 0.01983067877877326 > ./result_4chains/node212_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_0 -p 409 -st none -pt topic212_0_0 -u 0.015547656756219164 > ./result_4chains/node212_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_0 -p 840 -st none -pt topic212_1_0 -u 0.08226996337834702 > ./result_4chains/node212_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_0 -p 873 -st none -pt topic212_2_0 -u 0.12036035223713479 > ./result_4chains/node212_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_0 -p 948 -st none -pt topic212_3_0 -u 0.07072995955410687 > ./result_4chains/node212_3_0.txt &
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
    "./result_4chains/node212_0_0.txt 90"
    "./result_4chains/node212_0_2.txt 90"
    "./result_4chains/node212_1_0.txt 89"
    "./result_4chains/node212_1_2.txt 89"
    "./result_4chains/node212_2_0.txt 88"
    "./result_4chains/node212_2_2.txt 88"
    "./result_4chains/node212_3_0.txt 87"
    "./result_4chains/node212_3_2.txt 87"
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
