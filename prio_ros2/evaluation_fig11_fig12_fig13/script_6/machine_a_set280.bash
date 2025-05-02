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
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_2 -p 46 -st topic280_0_1 -pt None -u 0.01572661489085908 > ./result_6chains/node280_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_2 -p 84 -st topic280_1_1 -pt None -u 0.02980078358207272 > ./result_6chains/node280_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_2 -p 143 -st topic280_2_1 -pt None -u 0.0038086128288742638 > ./result_6chains/node280_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_2 -p 626 -st topic280_3_1 -pt None -u 0.05271900686158035 > ./result_6chains/node280_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_2 -p 693 -st topic280_4_1 -pt None -u 0.0099485991911442 > ./result_6chains/node280_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_2 -p 709 -st topic280_5_1 -pt None -u 0.01990510558869045 > ./result_6chains/node280_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_0 -p 46 -st none -pt topic280_0_0 -u 0.028548216341021726 > ./result_6chains/node280_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_0 -p 84 -st none -pt topic280_1_0 -u 0.002467063812480852 > ./result_6chains/node280_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_0 -p 143 -st none -pt topic280_2_0 -u 0.0920914296123263 > ./result_6chains/node280_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_0 -p 626 -st none -pt topic280_3_0 -u 0.026785197629818125 > ./result_6chains/node280_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_0 -p 693 -st none -pt topic280_4_0 -u 0.01510098903532206 > ./result_6chains/node280_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_0 -p 709 -st none -pt topic280_5_0 -u 0.04095831228747954 > ./result_6chains/node280_5_0.txt &
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
    "./result_6chains/node280_0_0.txt 90"
    "./result_6chains/node280_0_2.txt 90"
    "./result_6chains/node280_1_0.txt 89"
    "./result_6chains/node280_1_2.txt 89"
    "./result_6chains/node280_2_0.txt 88"
    "./result_6chains/node280_2_2.txt 88"
    "./result_6chains/node280_3_0.txt 87"
    "./result_6chains/node280_3_2.txt 87"
    "./result_6chains/node280_4_0.txt 86"
    "./result_6chains/node280_4_2.txt 86"
    "./result_6chains/node280_5_0.txt 85"
    "./result_6chains/node280_5_2.txt 85"
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
