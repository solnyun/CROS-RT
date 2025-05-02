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
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_2 -p 228 -st topic491_0_1 -pt None -u 0.03701262692157531 > ./result_6chains/node491_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_2 -p 229 -st topic491_1_1 -pt None -u 0.04741652554807102 > ./result_6chains/node491_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_2 -p 424 -st topic491_2_1 -pt None -u 0.03895240092824867 > ./result_6chains/node491_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_2 -p 469 -st topic491_3_1 -pt None -u 0.02077213278423988 > ./result_6chains/node491_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_2 -p 550 -st topic491_4_1 -pt None -u 0.039722989360385916 > ./result_6chains/node491_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_2 -p 660 -st topic491_5_1 -pt None -u 0.009480803961497962 > ./result_6chains/node491_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_0 -p 228 -st none -pt topic491_0_0 -u 0.001744855348844332 > ./result_6chains/node491_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_0 -p 229 -st none -pt topic491_1_0 -u 0.015875215778607787 > ./result_6chains/node491_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_0 -p 424 -st none -pt topic491_2_0 -u 0.01226618981606159 > ./result_6chains/node491_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_0 -p 469 -st none -pt topic491_3_0 -u 0.009332318315230348 > ./result_6chains/node491_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_0 -p 550 -st none -pt topic491_4_0 -u 0.008806715563018402 > ./result_6chains/node491_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_0 -p 660 -st none -pt topic491_5_0 -u 0.01645400446379243 > ./result_6chains/node491_5_0.txt &
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
    "./result_6chains/node491_0_0.txt 90"
    "./result_6chains/node491_0_2.txt 90"
    "./result_6chains/node491_1_0.txt 89"
    "./result_6chains/node491_1_2.txt 89"
    "./result_6chains/node491_2_0.txt 88"
    "./result_6chains/node491_2_2.txt 88"
    "./result_6chains/node491_3_0.txt 87"
    "./result_6chains/node491_3_2.txt 87"
    "./result_6chains/node491_4_0.txt 86"
    "./result_6chains/node491_4_2.txt 86"
    "./result_6chains/node491_5_0.txt 85"
    "./result_6chains/node491_5_2.txt 85"
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
