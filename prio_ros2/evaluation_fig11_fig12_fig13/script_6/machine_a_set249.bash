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
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_2 -p 295 -st topic249_0_1 -pt None -u 0.032287901752533155 > ./result_6chains/node249_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_2 -p 559 -st topic249_1_1 -pt None -u 0.00044286223496209365 > ./result_6chains/node249_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_2 -p 650 -st topic249_2_1 -pt None -u 0.05955554546184544 > ./result_6chains/node249_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_2 -p 681 -st topic249_3_1 -pt None -u 0.04919521862874754 > ./result_6chains/node249_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_2 -p 818 -st topic249_4_1 -pt None -u 0.03571187537259658 > ./result_6chains/node249_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_2 -p 819 -st topic249_5_1 -pt None -u 0.0135506477161429 > ./result_6chains/node249_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_0 -p 295 -st none -pt topic249_0_0 -u 0.021292045377172664 > ./result_6chains/node249_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_0 -p 559 -st none -pt topic249_1_0 -u 0.03269924365070059 > ./result_6chains/node249_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_0 -p 650 -st none -pt topic249_2_0 -u 0.0037051918671894835 > ./result_6chains/node249_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_0 -p 681 -st none -pt topic249_3_0 -u 0.010479693078110891 > ./result_6chains/node249_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_0 -p 818 -st none -pt topic249_4_0 -u 0.007457257447860383 > ./result_6chains/node249_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_0 -p 819 -st none -pt topic249_5_0 -u 0.004043505305340631 > ./result_6chains/node249_5_0.txt &
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
    "./result_6chains/node249_0_0.txt 90"
    "./result_6chains/node249_0_2.txt 90"
    "./result_6chains/node249_1_0.txt 89"
    "./result_6chains/node249_1_2.txt 89"
    "./result_6chains/node249_2_0.txt 88"
    "./result_6chains/node249_2_2.txt 88"
    "./result_6chains/node249_3_0.txt 87"
    "./result_6chains/node249_3_2.txt 87"
    "./result_6chains/node249_4_0.txt 86"
    "./result_6chains/node249_4_2.txt 86"
    "./result_6chains/node249_5_0.txt 85"
    "./result_6chains/node249_5_2.txt 85"
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
