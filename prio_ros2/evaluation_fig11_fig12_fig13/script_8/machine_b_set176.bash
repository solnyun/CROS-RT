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
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_1 -p 56 -st topic176_0_0 -pt topic176_0_1 -u 0.020233193213789413 > ./result_8chains/node176_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_1 -p 96 -st topic176_1_0 -pt topic176_1_1 -u 0.02265051487911035 > ./result_8chains/node176_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_1 -p 449 -st topic176_2_0 -pt topic176_2_1 -u 0.10767787439249737 > ./result_8chains/node176_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_1 -p 494 -st topic176_3_0 -pt topic176_3_1 -u 0.012072351161481587 > ./result_8chains/node176_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_1 -p 562 -st topic176_4_0 -pt topic176_4_1 -u 0.011415885645097962 > ./result_8chains/node176_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_1 -p 697 -st topic176_5_0 -pt topic176_5_1 -u 0.0035915784845228227 > ./result_8chains/node176_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_1 -p 798 -st topic176_6_0 -pt topic176_6_1 -u 0.006404716993421808 > ./result_8chains/node176_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_1 -p 825 -st topic176_7_0 -pt topic176_7_1 -u 0.047001838188684225 > ./result_8chains/node176_7_1.txt &
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
    "./result_8chains/node176_0_1.txt 90"
    "./result_8chains/node176_1_1.txt 89"
    "./result_8chains/node176_2_1.txt 88"
    "./result_8chains/node176_3_1.txt 87"
    "./result_8chains/node176_4_1.txt 86"
    "./result_8chains/node176_5_1.txt 85"
    "./result_8chains/node176_6_1.txt 84"
    "./result_8chains/node176_7_1.txt 83"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
