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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_2 -p 62 -st topic67_0_1 -pt None -u 0.045175232270337595 > ./result_6chains/node67_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_2 -p 270 -st topic67_1_1 -pt None -u 0.021936538475153033 > ./result_6chains/node67_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_2 -p 438 -st topic67_2_1 -pt None -u 0.023888545836936892 > ./result_6chains/node67_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_2 -p 470 -st topic67_3_1 -pt None -u 0.0339337995654041 > ./result_6chains/node67_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_2 -p 721 -st topic67_4_1 -pt None -u 0.001381472111881915 > ./result_6chains/node67_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_2 -p 833 -st topic67_5_1 -pt None -u 0.016158201410731154 > ./result_6chains/node67_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_0 -p 62 -st none -pt topic67_0_0 -u 0.012111776480784986 > ./result_6chains/node67_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_0 -p 270 -st none -pt topic67_1_0 -u 0.04634660156668191 > ./result_6chains/node67_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_0 -p 438 -st none -pt topic67_2_0 -u 0.016792197514234775 > ./result_6chains/node67_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_0 -p 470 -st none -pt topic67_3_0 -u 0.0019779517184879136 > ./result_6chains/node67_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_0 -p 721 -st none -pt topic67_4_0 -u 0.04401675409441114 > ./result_6chains/node67_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_0 -p 833 -st none -pt topic67_5_0 -u 0.05456205042122416 > ./result_6chains/node67_5_0.txt &
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
    "./result_6chains/node67_0_0.txt 90"
    "./result_6chains/node67_0_2.txt 90"
    "./result_6chains/node67_1_0.txt 89"
    "./result_6chains/node67_1_2.txt 89"
    "./result_6chains/node67_2_0.txt 88"
    "./result_6chains/node67_2_2.txt 88"
    "./result_6chains/node67_3_0.txt 87"
    "./result_6chains/node67_3_2.txt 87"
    "./result_6chains/node67_4_0.txt 86"
    "./result_6chains/node67_4_2.txt 86"
    "./result_6chains/node67_5_0.txt 85"
    "./result_6chains/node67_5_2.txt 85"
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
