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
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_2 -p 11 -st topic176_0_1 -pt None -u 0.012686511046709148 > ./result_6chains/node176_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_2 -p 124 -st topic176_1_1 -pt None -u 0.0865883810771807 > ./result_6chains/node176_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_2 -p 229 -st topic176_2_1 -pt None -u 0.002323994944288754 > ./result_6chains/node176_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_2 -p 509 -st topic176_3_1 -pt None -u 0.01409332726343876 > ./result_6chains/node176_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_2 -p 669 -st topic176_4_1 -pt None -u 0.05369999841268927 > ./result_6chains/node176_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_2 -p 930 -st topic176_5_1 -pt None -u 0.02318308694342973 > ./result_6chains/node176_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_0 -p 11 -st none -pt topic176_0_0 -u 0.009044117410681063 > ./result_6chains/node176_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_0 -p 124 -st none -pt topic176_1_0 -u 0.06884799205260661 > ./result_6chains/node176_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_0 -p 229 -st none -pt topic176_2_0 -u 0.028424402435735463 > ./result_6chains/node176_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_0 -p 509 -st none -pt topic176_3_0 -u 0.04768879365872114 > ./result_6chains/node176_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_0 -p 669 -st none -pt topic176_4_0 -u 0.019586624829559834 > ./result_6chains/node176_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_0 -p 930 -st none -pt topic176_5_0 -u 0.006010903818478047 > ./result_6chains/node176_5_0.txt &
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
    "./result_6chains/node176_0_0.txt 90"
    "./result_6chains/node176_0_2.txt 90"
    "./result_6chains/node176_1_0.txt 89"
    "./result_6chains/node176_1_2.txt 89"
    "./result_6chains/node176_2_0.txt 88"
    "./result_6chains/node176_2_2.txt 88"
    "./result_6chains/node176_3_0.txt 87"
    "./result_6chains/node176_3_2.txt 87"
    "./result_6chains/node176_4_0.txt 86"
    "./result_6chains/node176_4_2.txt 86"
    "./result_6chains/node176_5_0.txt 85"
    "./result_6chains/node176_5_2.txt 85"
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
