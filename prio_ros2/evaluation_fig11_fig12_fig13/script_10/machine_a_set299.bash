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
ros2 run evaluation_3_randomdag uunifast_node -n node299_0_2 -p 21 -st topic299_0_1 -pt None -u 0.0025124970466992025 > ./result_10chains/node299_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_1_2 -p 81 -st topic299_1_1 -pt None -u 0.01913963792549772 > ./result_10chains/node299_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_2_2 -p 95 -st topic299_2_1 -pt None -u 0.005595781041239756 > ./result_10chains/node299_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_3_2 -p 170 -st topic299_3_1 -pt None -u 0.01603187653618654 > ./result_10chains/node299_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_4_2 -p 256 -st topic299_4_1 -pt None -u 0.02452898076619725 > ./result_10chains/node299_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_5_2 -p 342 -st topic299_5_1 -pt None -u 0.00976023119479294 > ./result_10chains/node299_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_6_2 -p 437 -st topic299_6_1 -pt None -u 0.01738563854925443 > ./result_10chains/node299_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_7_2 -p 560 -st topic299_7_1 -pt None -u 0.005597909145546351 > ./result_10chains/node299_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_8_2 -p 698 -st topic299_8_1 -pt None -u 0.009257170383066393 > ./result_10chains/node299_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_9_2 -p 836 -st topic299_9_1 -pt None -u 0.0025282440422524266 > ./result_10chains/node299_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_0_0 -p 21 -st none -pt topic299_0_0 -u 0.006511671633414096 > ./result_10chains/node299_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_1_0 -p 81 -st none -pt topic299_1_0 -u 0.012126667849265083 > ./result_10chains/node299_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_2_0 -p 95 -st none -pt topic299_2_0 -u 0.0235578681824124 > ./result_10chains/node299_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_3_0 -p 170 -st none -pt topic299_3_0 -u 0.006412751517500925 > ./result_10chains/node299_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_4_0 -p 256 -st none -pt topic299_4_0 -u 0.014345755084744949 > ./result_10chains/node299_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_5_0 -p 342 -st none -pt topic299_5_0 -u 0.03915906734961311 > ./result_10chains/node299_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_6_0 -p 437 -st none -pt topic299_6_0 -u 0.043745678338420635 > ./result_10chains/node299_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_7_0 -p 560 -st none -pt topic299_7_0 -u 0.0324637252080926 > ./result_10chains/node299_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node299_8_0 -p 698 -st none -pt topic299_8_0 -u 3.640582078102278e-05 > ./result_10chains/node299_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node299_9_0 -p 836 -st none -pt topic299_9_0 -u 0.015545881331204187 > ./result_10chains/node299_9_0.txt &
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
    "./result_10chains/node299_0_0.txt 90"
    "./result_10chains/node299_0_2.txt 90"
    "./result_10chains/node299_1_0.txt 89"
    "./result_10chains/node299_1_2.txt 89"
    "./result_10chains/node299_2_0.txt 88"
    "./result_10chains/node299_2_2.txt 88"
    "./result_10chains/node299_3_0.txt 87"
    "./result_10chains/node299_3_2.txt 87"
    "./result_10chains/node299_4_0.txt 86"
    "./result_10chains/node299_4_2.txt 86"
    "./result_10chains/node299_5_0.txt 85"
    "./result_10chains/node299_5_2.txt 85"
    "./result_10chains/node299_6_0.txt 84"
    "./result_10chains/node299_6_2.txt 84"
    "./result_10chains/node299_7_0.txt 83"
    "./result_10chains/node299_7_2.txt 83"
    "./result_10chains/node299_8_0.txt 82"
    "./result_10chains/node299_8_2.txt 82"
    "./result_10chains/node299_9_0.txt 81"
    "./result_10chains/node299_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
