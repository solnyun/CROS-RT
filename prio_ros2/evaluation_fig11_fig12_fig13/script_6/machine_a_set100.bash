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
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_2 -p 38 -st topic100_0_1 -pt None -u 0.024242857592360723 > ./result_6chains/node100_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_2 -p 160 -st topic100_1_1 -pt None -u 0.005143785680299939 > ./result_6chains/node100_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_2 -p 576 -st topic100_2_1 -pt None -u 0.007966430285667347 > ./result_6chains/node100_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_2 -p 630 -st topic100_3_1 -pt None -u 0.11987919784725934 > ./result_6chains/node100_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_2 -p 644 -st topic100_4_1 -pt None -u 0.048539577711521745 > ./result_6chains/node100_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_2 -p 690 -st topic100_5_1 -pt None -u 0.0437215612449383 > ./result_6chains/node100_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_0 -p 38 -st none -pt topic100_0_0 -u 0.05503959450245338 > ./result_6chains/node100_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_0 -p 160 -st none -pt topic100_1_0 -u 0.003473684938935351 > ./result_6chains/node100_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_0 -p 576 -st none -pt topic100_2_0 -u 0.030500364257284418 > ./result_6chains/node100_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_0 -p 630 -st none -pt topic100_3_0 -u 0.004407541303594553 > ./result_6chains/node100_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_0 -p 644 -st none -pt topic100_4_0 -u 0.000564022589304658 > ./result_6chains/node100_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_0 -p 690 -st none -pt topic100_5_0 -u 0.0035867668002700775 > ./result_6chains/node100_5_0.txt &
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
    "./result_6chains/node100_0_0.txt 90"
    "./result_6chains/node100_0_2.txt 90"
    "./result_6chains/node100_1_0.txt 89"
    "./result_6chains/node100_1_2.txt 89"
    "./result_6chains/node100_2_0.txt 88"
    "./result_6chains/node100_2_2.txt 88"
    "./result_6chains/node100_3_0.txt 87"
    "./result_6chains/node100_3_2.txt 87"
    "./result_6chains/node100_4_0.txt 86"
    "./result_6chains/node100_4_2.txt 86"
    "./result_6chains/node100_5_0.txt 85"
    "./result_6chains/node100_5_2.txt 85"
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
