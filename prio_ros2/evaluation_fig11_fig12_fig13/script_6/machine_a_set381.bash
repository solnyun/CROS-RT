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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_2 -p 47 -st topic381_0_1 -pt None -u 0.041135063322452925 > ./result_6chains/node381_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_2 -p 149 -st topic381_1_1 -pt None -u 0.03619247722974228 > ./result_6chains/node381_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_2 -p 538 -st topic381_2_1 -pt None -u 0.008563597724801753 > ./result_6chains/node381_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_2 -p 718 -st topic381_3_1 -pt None -u 0.016204504866334346 > ./result_6chains/node381_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_2 -p 854 -st topic381_4_1 -pt None -u 0.03651497120965502 > ./result_6chains/node381_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_2 -p 991 -st topic381_5_1 -pt None -u 0.005900765173138698 > ./result_6chains/node381_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_0 -p 47 -st none -pt topic381_0_0 -u 0.020984561396220736 > ./result_6chains/node381_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_0 -p 149 -st none -pt topic381_1_0 -u 0.025325244166867766 > ./result_6chains/node381_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_0 -p 538 -st none -pt topic381_2_0 -u 0.0053818980439554465 > ./result_6chains/node381_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_0 -p 718 -st none -pt topic381_3_0 -u 0.009318791794607872 > ./result_6chains/node381_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_0 -p 854 -st none -pt topic381_4_0 -u 0.008581167936446088 > ./result_6chains/node381_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_0 -p 991 -st none -pt topic381_5_0 -u 0.11413003498532381 > ./result_6chains/node381_5_0.txt &
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
    "./result_6chains/node381_0_0.txt 90"
    "./result_6chains/node381_0_2.txt 90"
    "./result_6chains/node381_1_0.txt 89"
    "./result_6chains/node381_1_2.txt 89"
    "./result_6chains/node381_2_0.txt 88"
    "./result_6chains/node381_2_2.txt 88"
    "./result_6chains/node381_3_0.txt 87"
    "./result_6chains/node381_3_2.txt 87"
    "./result_6chains/node381_4_0.txt 86"
    "./result_6chains/node381_4_2.txt 86"
    "./result_6chains/node381_5_0.txt 85"
    "./result_6chains/node381_5_2.txt 85"
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
