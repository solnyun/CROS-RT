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
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_2 -p 348 -st topic367_0_1 -pt None -u 0.03736631153026376 > ./result_4chains/node367_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_2 -p 689 -st topic367_1_1 -pt None -u 0.048951794491569944 > ./result_4chains/node367_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_2 -p 822 -st topic367_2_1 -pt None -u 0.03580134499584334 > ./result_4chains/node367_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_2 -p 945 -st topic367_3_1 -pt None -u 0.04577137985972963 > ./result_4chains/node367_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_0 -p 348 -st none -pt topic367_0_0 -u 0.007226415820128174 > ./result_4chains/node367_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_0 -p 689 -st none -pt topic367_1_0 -u 0.006328681616554421 > ./result_4chains/node367_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_0 -p 822 -st none -pt topic367_2_0 -u 0.010871582150723758 > ./result_4chains/node367_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_0 -p 945 -st none -pt topic367_3_0 -u 0.0059825152809489385 > ./result_4chains/node367_3_0.txt &
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
    "./result_4chains/node367_0_0.txt 90"
    "./result_4chains/node367_0_2.txt 90"
    "./result_4chains/node367_1_0.txt 89"
    "./result_4chains/node367_1_2.txt 89"
    "./result_4chains/node367_2_0.txt 88"
    "./result_4chains/node367_2_2.txt 88"
    "./result_4chains/node367_3_0.txt 87"
    "./result_4chains/node367_3_2.txt 87"
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
