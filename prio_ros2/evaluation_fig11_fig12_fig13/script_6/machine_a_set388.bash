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
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_2 -p 21 -st topic388_0_1 -pt None -u 0.13549794959612066 > ./result_6chains/node388_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_2 -p 112 -st topic388_1_1 -pt None -u 0.029809339709146898 > ./result_6chains/node388_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_2 -p 226 -st topic388_2_1 -pt None -u 0.030684588339564223 > ./result_6chains/node388_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_2 -p 276 -st topic388_3_1 -pt None -u 0.01579050635921664 > ./result_6chains/node388_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_2 -p 424 -st topic388_4_1 -pt None -u 0.0866651303526999 > ./result_6chains/node388_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_2 -p 819 -st topic388_5_1 -pt None -u 0.02121867382871692 > ./result_6chains/node388_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_0 -p 21 -st none -pt topic388_0_0 -u 0.04233813896944 > ./result_6chains/node388_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_0 -p 112 -st none -pt topic388_1_0 -u 0.01163158193620889 > ./result_6chains/node388_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_0 -p 226 -st none -pt topic388_2_0 -u 0.0025163321461237897 > ./result_6chains/node388_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_0 -p 276 -st none -pt topic388_3_0 -u 0.012516979761409947 > ./result_6chains/node388_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_0 -p 424 -st none -pt topic388_4_0 -u 0.007473028027356804 > ./result_6chains/node388_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_0 -p 819 -st none -pt topic388_5_0 -u 0.0013376651455837205 > ./result_6chains/node388_5_0.txt &
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
    "./result_6chains/node388_0_0.txt 90"
    "./result_6chains/node388_0_2.txt 90"
    "./result_6chains/node388_1_0.txt 89"
    "./result_6chains/node388_1_2.txt 89"
    "./result_6chains/node388_2_0.txt 88"
    "./result_6chains/node388_2_2.txt 88"
    "./result_6chains/node388_3_0.txt 87"
    "./result_6chains/node388_3_2.txt 87"
    "./result_6chains/node388_4_0.txt 86"
    "./result_6chains/node388_4_2.txt 86"
    "./result_6chains/node388_5_0.txt 85"
    "./result_6chains/node388_5_2.txt 85"
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
