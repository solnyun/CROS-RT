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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_2 -p 244 -st topic310_0_1 -pt None -u 0.007165657979579687 > ./result_6chains/node310_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_2 -p 433 -st topic310_1_1 -pt None -u 0.006671132737939234 > ./result_6chains/node310_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_2 -p 514 -st topic310_2_1 -pt None -u 0.028661767954147377 > ./result_6chains/node310_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_2 -p 557 -st topic310_3_1 -pt None -u 0.010900046545248343 > ./result_6chains/node310_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_2 -p 625 -st topic310_4_1 -pt None -u 0.05431173967795677 > ./result_6chains/node310_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_2 -p 901 -st topic310_5_1 -pt None -u 0.07684500314873385 > ./result_6chains/node310_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_0 -p 244 -st none -pt topic310_0_0 -u 0.027450736845091417 > ./result_6chains/node310_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_0 -p 433 -st none -pt topic310_1_0 -u 0.023513639774462858 > ./result_6chains/node310_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_0 -p 514 -st none -pt topic310_2_0 -u 0.00727852947038754 > ./result_6chains/node310_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_0 -p 557 -st none -pt topic310_3_0 -u 0.007399529901097102 > ./result_6chains/node310_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_0 -p 625 -st none -pt topic310_4_0 -u 0.0038749908068212435 > ./result_6chains/node310_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_0 -p 901 -st none -pt topic310_5_0 -u 0.031056785682277807 > ./result_6chains/node310_5_0.txt &
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
    "./result_6chains/node310_0_0.txt 90"
    "./result_6chains/node310_0_2.txt 90"
    "./result_6chains/node310_1_0.txt 89"
    "./result_6chains/node310_1_2.txt 89"
    "./result_6chains/node310_2_0.txt 88"
    "./result_6chains/node310_2_2.txt 88"
    "./result_6chains/node310_3_0.txt 87"
    "./result_6chains/node310_3_2.txt 87"
    "./result_6chains/node310_4_0.txt 86"
    "./result_6chains/node310_4_2.txt 86"
    "./result_6chains/node310_5_0.txt 85"
    "./result_6chains/node310_5_2.txt 85"
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
