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
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_2 -p 35 -st topic120_0_1 -pt None -u 0.0034330450715520655 > ./result_6chains/node120_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_2 -p 306 -st topic120_1_1 -pt None -u 0.07574511927395744 > ./result_6chains/node120_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_2 -p 452 -st topic120_2_1 -pt None -u 0.030799149470009335 > ./result_6chains/node120_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_2 -p 485 -st topic120_3_1 -pt None -u 0.03334086165803646 > ./result_6chains/node120_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_2 -p 613 -st topic120_4_1 -pt None -u 0.02174083824252504 > ./result_6chains/node120_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_2 -p 736 -st topic120_5_1 -pt None -u 0.05008492669581709 > ./result_6chains/node120_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_0 -p 35 -st none -pt topic120_0_0 -u 0.024426122626946933 > ./result_6chains/node120_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_0 -p 306 -st none -pt topic120_1_0 -u 0.00414541370654975 > ./result_6chains/node120_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_0 -p 452 -st none -pt topic120_2_0 -u 0.046369784909466805 > ./result_6chains/node120_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_0 -p 485 -st none -pt topic120_3_0 -u 0.04602440947602843 > ./result_6chains/node120_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_0 -p 613 -st none -pt topic120_4_0 -u 0.06900684362488611 > ./result_6chains/node120_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_0 -p 736 -st none -pt topic120_5_0 -u 0.00467346553183208 > ./result_6chains/node120_5_0.txt &
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
    "./result_6chains/node120_0_0.txt 90"
    "./result_6chains/node120_0_2.txt 90"
    "./result_6chains/node120_1_0.txt 89"
    "./result_6chains/node120_1_2.txt 89"
    "./result_6chains/node120_2_0.txt 88"
    "./result_6chains/node120_2_2.txt 88"
    "./result_6chains/node120_3_0.txt 87"
    "./result_6chains/node120_3_2.txt 87"
    "./result_6chains/node120_4_0.txt 86"
    "./result_6chains/node120_4_2.txt 86"
    "./result_6chains/node120_5_0.txt 85"
    "./result_6chains/node120_5_2.txt 85"
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
