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
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_2 -p 152 -st topic419_0_1 -pt None -u 0.024394006609482877 > ./result_6chains/node419_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_2 -p 199 -st topic419_1_1 -pt None -u 0.010366121210886037 > ./result_6chains/node419_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_2 -p 383 -st topic419_2_1 -pt None -u 0.02282800356296011 > ./result_6chains/node419_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_2 -p 407 -st topic419_3_1 -pt None -u 0.048041445994294746 > ./result_6chains/node419_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_2 -p 715 -st topic419_4_1 -pt None -u 0.016411970768809403 > ./result_6chains/node419_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_2 -p 994 -st topic419_5_1 -pt None -u 0.027786189975829927 > ./result_6chains/node419_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_0 -p 152 -st none -pt topic419_0_0 -u 0.017028811116701792 > ./result_6chains/node419_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_0 -p 199 -st none -pt topic419_1_0 -u 0.0006187502265451172 > ./result_6chains/node419_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_0 -p 383 -st none -pt topic419_2_0 -u 0.03910997859945731 > ./result_6chains/node419_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_0 -p 407 -st none -pt topic419_3_0 -u 0.0018842062419369698 > ./result_6chains/node419_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_0 -p 715 -st none -pt topic419_4_0 -u 0.011546573712240299 > ./result_6chains/node419_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_0 -p 994 -st none -pt topic419_5_0 -u 0.08753231054739069 > ./result_6chains/node419_5_0.txt &
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
    "./result_6chains/node419_0_0.txt 90"
    "./result_6chains/node419_0_2.txt 90"
    "./result_6chains/node419_1_0.txt 89"
    "./result_6chains/node419_1_2.txt 89"
    "./result_6chains/node419_2_0.txt 88"
    "./result_6chains/node419_2_2.txt 88"
    "./result_6chains/node419_3_0.txt 87"
    "./result_6chains/node419_3_2.txt 87"
    "./result_6chains/node419_4_0.txt 86"
    "./result_6chains/node419_4_2.txt 86"
    "./result_6chains/node419_5_0.txt 85"
    "./result_6chains/node419_5_2.txt 85"
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
