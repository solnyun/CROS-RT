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
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_2 -p 39 -st topic114_0_1 -pt None -u 0.014142585494486604 > ./result_6chains/node114_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_2 -p 48 -st topic114_1_1 -pt None -u 0.0019284953365219515 > ./result_6chains/node114_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_2 -p 560 -st topic114_2_1 -pt None -u 0.03309692877706255 > ./result_6chains/node114_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_2 -p 653 -st topic114_3_1 -pt None -u 0.026433218066450992 > ./result_6chains/node114_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_2 -p 777 -st topic114_4_1 -pt None -u 0.06914581466200416 > ./result_6chains/node114_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_2 -p 861 -st topic114_5_1 -pt None -u 0.026201118605489026 > ./result_6chains/node114_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_0 -p 39 -st none -pt topic114_0_0 -u 0.016996076281245165 > ./result_6chains/node114_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_0 -p 48 -st none -pt topic114_1_0 -u 0.019535281510458635 > ./result_6chains/node114_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_0 -p 560 -st none -pt topic114_2_0 -u 0.09527553715693171 > ./result_6chains/node114_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_0 -p 653 -st none -pt topic114_3_0 -u 0.0444376373969797 > ./result_6chains/node114_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_0 -p 777 -st none -pt topic114_4_0 -u 0.002905320347762419 > ./result_6chains/node114_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_0 -p 861 -st none -pt topic114_5_0 -u 0.08336812073073169 > ./result_6chains/node114_5_0.txt &
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
    "./result_6chains/node114_0_0.txt 90"
    "./result_6chains/node114_0_2.txt 90"
    "./result_6chains/node114_1_0.txt 89"
    "./result_6chains/node114_1_2.txt 89"
    "./result_6chains/node114_2_0.txt 88"
    "./result_6chains/node114_2_2.txt 88"
    "./result_6chains/node114_3_0.txt 87"
    "./result_6chains/node114_3_2.txt 87"
    "./result_6chains/node114_4_0.txt 86"
    "./result_6chains/node114_4_2.txt 86"
    "./result_6chains/node114_5_0.txt 85"
    "./result_6chains/node114_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
