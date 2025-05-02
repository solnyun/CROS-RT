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
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_2 -p 347 -st topic405_0_1 -pt None -u 0.02135559453701269 > ./result_4chains/node405_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_2 -p 396 -st topic405_1_1 -pt None -u 0.1224174583785734 > ./result_4chains/node405_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_2 -p 545 -st topic405_2_1 -pt None -u 0.0335768067213853 > ./result_4chains/node405_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_2 -p 858 -st topic405_3_1 -pt None -u 0.007587307738871004 > ./result_4chains/node405_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_0 -p 347 -st none -pt topic405_0_0 -u 0.10510733828221458 > ./result_4chains/node405_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_0 -p 396 -st none -pt topic405_1_0 -u 0.009148998767358252 > ./result_4chains/node405_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_0 -p 545 -st none -pt topic405_2_0 -u 0.010657572162626694 > ./result_4chains/node405_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_0 -p 858 -st none -pt topic405_3_0 -u 0.09363157176968698 > ./result_4chains/node405_3_0.txt &
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
    "./result_4chains/node405_0_0.txt 90"
    "./result_4chains/node405_0_2.txt 90"
    "./result_4chains/node405_1_0.txt 89"
    "./result_4chains/node405_1_2.txt 89"
    "./result_4chains/node405_2_0.txt 88"
    "./result_4chains/node405_2_2.txt 88"
    "./result_4chains/node405_3_0.txt 87"
    "./result_4chains/node405_3_2.txt 87"
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
