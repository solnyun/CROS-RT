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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_2 -p 29 -st topic117_0_1 -pt None -u 0.04362521445958978 > ./result_4chains/node117_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_2 -p 33 -st topic117_1_1 -pt None -u 0.0288308971671129 > ./result_4chains/node117_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_2 -p 637 -st topic117_2_1 -pt None -u 0.03625484684229968 > ./result_4chains/node117_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_2 -p 961 -st topic117_3_1 -pt None -u 0.0708436715718662 > ./result_4chains/node117_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_0 -p 29 -st none -pt topic117_0_0 -u 0.022415385193613246 > ./result_4chains/node117_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_0 -p 33 -st none -pt topic117_1_0 -u 0.07136877938150882 > ./result_4chains/node117_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_0 -p 637 -st none -pt topic117_2_0 -u 0.04795657050750868 > ./result_4chains/node117_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_0 -p 961 -st none -pt topic117_3_0 -u 0.02758571776967897 > ./result_4chains/node117_3_0.txt &
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
    "./result_4chains/node117_0_0.txt 90"
    "./result_4chains/node117_0_2.txt 90"
    "./result_4chains/node117_1_0.txt 89"
    "./result_4chains/node117_1_2.txt 89"
    "./result_4chains/node117_2_0.txt 88"
    "./result_4chains/node117_2_2.txt 88"
    "./result_4chains/node117_3_0.txt 87"
    "./result_4chains/node117_3_2.txt 87"
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
