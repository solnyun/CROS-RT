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
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_1 -p 78 -st topic309_0_0 -pt topic309_0_1 -u 0.005946638402323456 > ./result_10chains/node309_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_1 -p 143 -st topic309_1_0 -pt topic309_1_1 -u 0.02430453396807719 > ./result_10chains/node309_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_1 -p 546 -st topic309_2_0 -pt topic309_2_1 -u 0.008181462347616797 > ./result_10chains/node309_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_1 -p 553 -st topic309_3_0 -pt topic309_3_1 -u 0.020355596003694854 > ./result_10chains/node309_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_1 -p 706 -st topic309_4_0 -pt topic309_4_1 -u 0.007731865654232006 > ./result_10chains/node309_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_1 -p 788 -st topic309_5_0 -pt topic309_5_1 -u 0.008642349753778589 > ./result_10chains/node309_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_6_1 -p 856 -st topic309_6_0 -pt topic309_6_1 -u 0.004733664849279423 > ./result_10chains/node309_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_7_1 -p 939 -st topic309_7_0 -pt topic309_7_1 -u 0.008290188037496704 > ./result_10chains/node309_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_8_1 -p 955 -st topic309_8_0 -pt topic309_8_1 -u 0.015694381655524947 > ./result_10chains/node309_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_9_1 -p 959 -st topic309_9_0 -pt topic309_9_1 -u 0.0046778773774595744 > ./result_10chains/node309_9_1.txt &
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
    "./result_10chains/node309_0_1.txt 90"
    "./result_10chains/node309_1_1.txt 89"
    "./result_10chains/node309_2_1.txt 88"
    "./result_10chains/node309_3_1.txt 87"
    "./result_10chains/node309_4_1.txt 86"
    "./result_10chains/node309_5_1.txt 85"
    "./result_10chains/node309_6_1.txt 84"
    "./result_10chains/node309_7_1.txt 83"
    "./result_10chains/node309_8_1.txt 82"
    "./result_10chains/node309_9_1.txt 81"
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
