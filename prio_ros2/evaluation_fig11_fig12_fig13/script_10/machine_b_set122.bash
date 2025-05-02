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
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_1 -p 62 -st topic122_0_0 -pt topic122_0_1 -u 0.022497186581925177 > ./result_10chains/node122_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_1 -p 142 -st topic122_1_0 -pt topic122_1_1 -u 0.00658198246277375 > ./result_10chains/node122_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_1 -p 177 -st topic122_2_0 -pt topic122_2_1 -u 0.018051953944700605 > ./result_10chains/node122_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_1 -p 214 -st topic122_3_0 -pt topic122_3_1 -u 0.020981227630022803 > ./result_10chains/node122_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_1 -p 298 -st topic122_4_0 -pt topic122_4_1 -u 0.012359649599158196 > ./result_10chains/node122_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_1 -p 506 -st topic122_5_0 -pt topic122_5_1 -u 0.02345521923651761 > ./result_10chains/node122_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_1 -p 690 -st topic122_6_0 -pt topic122_6_1 -u 0.021909859414326133 > ./result_10chains/node122_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_1 -p 727 -st topic122_7_0 -pt topic122_7_1 -u 0.06474653966355343 > ./result_10chains/node122_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_8_1 -p 887 -st topic122_8_0 -pt topic122_8_1 -u 0.017991410487434814 > ./result_10chains/node122_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_9_1 -p 950 -st topic122_9_0 -pt topic122_9_1 -u 0.060595156024569746 > ./result_10chains/node122_9_1.txt &
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
    "./result_10chains/node122_0_1.txt 90"
    "./result_10chains/node122_1_1.txt 89"
    "./result_10chains/node122_2_1.txt 88"
    "./result_10chains/node122_3_1.txt 87"
    "./result_10chains/node122_4_1.txt 86"
    "./result_10chains/node122_5_1.txt 85"
    "./result_10chains/node122_6_1.txt 84"
    "./result_10chains/node122_7_1.txt 83"
    "./result_10chains/node122_8_1.txt 82"
    "./result_10chains/node122_9_1.txt 81"
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
