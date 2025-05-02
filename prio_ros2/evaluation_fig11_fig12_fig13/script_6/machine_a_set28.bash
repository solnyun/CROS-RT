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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_2 -p 424 -st topic28_0_1 -pt None -u 0.06124532831108198 > ./result_6chains/node28_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_2 -p 437 -st topic28_1_1 -pt None -u 0.011292153685023565 > ./result_6chains/node28_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_2 -p 596 -st topic28_2_1 -pt None -u 0.053179375570445525 > ./result_6chains/node28_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_2 -p 630 -st topic28_3_1 -pt None -u 0.011269869758874784 > ./result_6chains/node28_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_2 -p 640 -st topic28_4_1 -pt None -u 0.01948306746045965 > ./result_6chains/node28_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_2 -p 921 -st topic28_5_1 -pt None -u 0.0005363874392924243 > ./result_6chains/node28_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_0 -p 424 -st none -pt topic28_0_0 -u 0.016411048188224253 > ./result_6chains/node28_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_0 -p 437 -st none -pt topic28_1_0 -u 0.06962118277410595 > ./result_6chains/node28_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_0 -p 596 -st none -pt topic28_2_0 -u 0.02950812583516177 > ./result_6chains/node28_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_0 -p 630 -st none -pt topic28_3_0 -u 0.01480242003686913 > ./result_6chains/node28_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_0 -p 640 -st none -pt topic28_4_0 -u 0.02062828018950387 > ./result_6chains/node28_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_0 -p 921 -st none -pt topic28_5_0 -u 0.011815564318153511 > ./result_6chains/node28_5_0.txt &
sleep 10
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
    "./result_6chains/node28_0_0.txt 90"
    "./result_6chains/node28_0_2.txt 90"
    "./result_6chains/node28_1_0.txt 89"
    "./result_6chains/node28_1_2.txt 89"
    "./result_6chains/node28_2_0.txt 88"
    "./result_6chains/node28_2_2.txt 88"
    "./result_6chains/node28_3_0.txt 87"
    "./result_6chains/node28_3_2.txt 87"
    "./result_6chains/node28_4_0.txt 86"
    "./result_6chains/node28_4_2.txt 86"
    "./result_6chains/node28_5_0.txt 85"
    "./result_6chains/node28_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
