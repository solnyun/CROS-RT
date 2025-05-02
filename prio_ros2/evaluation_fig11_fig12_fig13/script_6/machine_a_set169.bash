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
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_2 -p 32 -st topic169_0_1 -pt None -u 0.013868418131834759 > ./result_6chains/node169_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_2 -p 382 -st topic169_1_1 -pt None -u 0.0077175172365459566 > ./result_6chains/node169_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_2 -p 527 -st topic169_2_1 -pt None -u 0.0389493051585828 > ./result_6chains/node169_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_2 -p 614 -st topic169_3_1 -pt None -u 0.007082318431805484 > ./result_6chains/node169_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_2 -p 751 -st topic169_4_1 -pt None -u 0.07032535252257051 > ./result_6chains/node169_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_2 -p 795 -st topic169_5_1 -pt None -u 0.00256122674246756 > ./result_6chains/node169_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_0 -p 32 -st none -pt topic169_0_0 -u 0.044873379068357866 > ./result_6chains/node169_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_0 -p 382 -st none -pt topic169_1_0 -u 0.008117190138573926 > ./result_6chains/node169_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_0 -p 527 -st none -pt topic169_2_0 -u 0.03404659165278373 > ./result_6chains/node169_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_0 -p 614 -st none -pt topic169_3_0 -u 0.0011476998326764576 > ./result_6chains/node169_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_0 -p 751 -st none -pt topic169_4_0 -u 0.015683418827569656 > ./result_6chains/node169_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_0 -p 795 -st none -pt topic169_5_0 -u 0.021381640835374548 > ./result_6chains/node169_5_0.txt &
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
    "./result_6chains/node169_0_0.txt 90"
    "./result_6chains/node169_0_2.txt 90"
    "./result_6chains/node169_1_0.txt 89"
    "./result_6chains/node169_1_2.txt 89"
    "./result_6chains/node169_2_0.txt 88"
    "./result_6chains/node169_2_2.txt 88"
    "./result_6chains/node169_3_0.txt 87"
    "./result_6chains/node169_3_2.txt 87"
    "./result_6chains/node169_4_0.txt 86"
    "./result_6chains/node169_4_2.txt 86"
    "./result_6chains/node169_5_0.txt 85"
    "./result_6chains/node169_5_2.txt 85"
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
