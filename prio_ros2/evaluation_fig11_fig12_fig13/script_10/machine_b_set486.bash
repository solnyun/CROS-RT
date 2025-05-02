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
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_1 -p 33 -st topic486_0_0 -pt topic486_0_1 -u 0.03875921994086168 > ./result_10chains/node486_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_1 -p 191 -st topic486_1_0 -pt topic486_1_1 -u 0.011968302643982631 > ./result_10chains/node486_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_1 -p 219 -st topic486_2_0 -pt topic486_2_1 -u 0.050998673199288636 > ./result_10chains/node486_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_1 -p 233 -st topic486_3_0 -pt topic486_3_1 -u 0.013613542304385273 > ./result_10chains/node486_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_4_1 -p 374 -st topic486_4_0 -pt topic486_4_1 -u 0.008041896951531624 > ./result_10chains/node486_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_5_1 -p 385 -st topic486_5_0 -pt topic486_5_1 -u 0.019915789945591678 > ./result_10chains/node486_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_6_1 -p 423 -st topic486_6_0 -pt topic486_6_1 -u 0.0010893037985687803 > ./result_10chains/node486_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_7_1 -p 473 -st topic486_7_0 -pt topic486_7_1 -u 0.042317884699840214 > ./result_10chains/node486_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_8_1 -p 652 -st topic486_8_0 -pt topic486_8_1 -u 0.0014782150648484788 > ./result_10chains/node486_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_9_1 -p 903 -st topic486_9_0 -pt topic486_9_1 -u 0.006366676935477917 > ./result_10chains/node486_9_1.txt &
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
    "./result_10chains/node486_0_1.txt 90"
    "./result_10chains/node486_1_1.txt 89"
    "./result_10chains/node486_2_1.txt 88"
    "./result_10chains/node486_3_1.txt 87"
    "./result_10chains/node486_4_1.txt 86"
    "./result_10chains/node486_5_1.txt 85"
    "./result_10chains/node486_6_1.txt 84"
    "./result_10chains/node486_7_1.txt 83"
    "./result_10chains/node486_8_1.txt 82"
    "./result_10chains/node486_9_1.txt 81"
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
