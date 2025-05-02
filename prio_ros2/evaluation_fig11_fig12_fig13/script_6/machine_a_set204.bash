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
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_2 -p 68 -st topic204_0_1 -pt None -u 0.006935394006997608 > ./result_6chains/node204_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_2 -p 272 -st topic204_1_1 -pt None -u 0.00543207222596831 > ./result_6chains/node204_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_2 -p 477 -st topic204_2_1 -pt None -u 0.03534769886090611 > ./result_6chains/node204_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_2 -p 773 -st topic204_3_1 -pt None -u 0.009440912745960567 > ./result_6chains/node204_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_2 -p 813 -st topic204_4_1 -pt None -u 0.002027720743861594 > ./result_6chains/node204_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_2 -p 848 -st topic204_5_1 -pt None -u 0.03151918700039305 > ./result_6chains/node204_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_0 -p 68 -st none -pt topic204_0_0 -u 0.050173311853344615 > ./result_6chains/node204_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_0 -p 272 -st none -pt topic204_1_0 -u 0.06961114745841263 > ./result_6chains/node204_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_0 -p 477 -st none -pt topic204_2_0 -u 0.002584895094323858 > ./result_6chains/node204_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_0 -p 773 -st none -pt topic204_3_0 -u 0.06256588294554938 > ./result_6chains/node204_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_0 -p 813 -st none -pt topic204_4_0 -u 0.028893858683215007 > ./result_6chains/node204_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_0 -p 848 -st none -pt topic204_5_0 -u 0.004848051181952723 > ./result_6chains/node204_5_0.txt &
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
    "./result_6chains/node204_0_0.txt 90"
    "./result_6chains/node204_0_2.txt 90"
    "./result_6chains/node204_1_0.txt 89"
    "./result_6chains/node204_1_2.txt 89"
    "./result_6chains/node204_2_0.txt 88"
    "./result_6chains/node204_2_2.txt 88"
    "./result_6chains/node204_3_0.txt 87"
    "./result_6chains/node204_3_2.txt 87"
    "./result_6chains/node204_4_0.txt 86"
    "./result_6chains/node204_4_2.txt 86"
    "./result_6chains/node204_5_0.txt 85"
    "./result_6chains/node204_5_2.txt 85"
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
