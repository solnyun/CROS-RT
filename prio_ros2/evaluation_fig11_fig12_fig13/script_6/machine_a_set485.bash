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
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_2 -p 87 -st topic485_0_1 -pt None -u 0.03601956493669767 > ./result_6chains/node485_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_2 -p 172 -st topic485_1_1 -pt None -u 0.019311252455588956 > ./result_6chains/node485_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_2 -p 408 -st topic485_2_1 -pt None -u 0.017240694894184866 > ./result_6chains/node485_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_2 -p 464 -st topic485_3_1 -pt None -u 0.003958901387317498 > ./result_6chains/node485_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_2 -p 606 -st topic485_4_1 -pt None -u 0.0002092063466692523 > ./result_6chains/node485_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_2 -p 736 -st topic485_5_1 -pt None -u 0.010568370635801922 > ./result_6chains/node485_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_0 -p 87 -st none -pt topic485_0_0 -u 0.045887208281282454 > ./result_6chains/node485_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_0 -p 172 -st none -pt topic485_1_0 -u 0.0533823700715465 > ./result_6chains/node485_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_0 -p 408 -st none -pt topic485_2_0 -u 0.06792350797565838 > ./result_6chains/node485_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_0 -p 464 -st none -pt topic485_3_0 -u 0.0016503727985296146 > ./result_6chains/node485_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_0 -p 606 -st none -pt topic485_4_0 -u 0.06138054095306324 > ./result_6chains/node485_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_0 -p 736 -st none -pt topic485_5_0 -u 0.08374579808422838 > ./result_6chains/node485_5_0.txt &
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
    "./result_6chains/node485_0_0.txt 90"
    "./result_6chains/node485_0_2.txt 90"
    "./result_6chains/node485_1_0.txt 89"
    "./result_6chains/node485_1_2.txt 89"
    "./result_6chains/node485_2_0.txt 88"
    "./result_6chains/node485_2_2.txt 88"
    "./result_6chains/node485_3_0.txt 87"
    "./result_6chains/node485_3_2.txt 87"
    "./result_6chains/node485_4_0.txt 86"
    "./result_6chains/node485_4_2.txt 86"
    "./result_6chains/node485_5_0.txt 85"
    "./result_6chains/node485_5_2.txt 85"
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
