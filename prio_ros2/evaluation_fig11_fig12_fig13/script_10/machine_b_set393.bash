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
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_1 -p 145 -st topic393_0_0 -pt topic393_0_1 -u 0.022074391679792915 > ./result_10chains/node393_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_1 -p 439 -st topic393_1_0 -pt topic393_1_1 -u 0.022776759134554736 > ./result_10chains/node393_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_1 -p 501 -st topic393_2_0 -pt topic393_2_1 -u 0.002867406270005146 > ./result_10chains/node393_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_1 -p 659 -st topic393_3_0 -pt topic393_3_1 -u 0.021866659197932403 > ./result_10chains/node393_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_1 -p 678 -st topic393_4_0 -pt topic393_4_1 -u 0.0017552921491010287 > ./result_10chains/node393_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_1 -p 781 -st topic393_5_0 -pt topic393_5_1 -u 0.005026472947312288 > ./result_10chains/node393_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_6_1 -p 838 -st topic393_6_0 -pt topic393_6_1 -u 0.011568393158341878 > ./result_10chains/node393_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_7_1 -p 899 -st topic393_7_0 -pt topic393_7_1 -u 0.011045475244511521 > ./result_10chains/node393_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_8_1 -p 902 -st topic393_8_0 -pt topic393_8_1 -u 0.0008115538263280542 > ./result_10chains/node393_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_9_1 -p 961 -st topic393_9_0 -pt topic393_9_1 -u 0.008389492668623759 > ./result_10chains/node393_9_1.txt &
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
    "./result_10chains/node393_0_1.txt 90"
    "./result_10chains/node393_1_1.txt 89"
    "./result_10chains/node393_2_1.txt 88"
    "./result_10chains/node393_3_1.txt 87"
    "./result_10chains/node393_4_1.txt 86"
    "./result_10chains/node393_5_1.txt 85"
    "./result_10chains/node393_6_1.txt 84"
    "./result_10chains/node393_7_1.txt 83"
    "./result_10chains/node393_8_1.txt 82"
    "./result_10chains/node393_9_1.txt 81"
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
