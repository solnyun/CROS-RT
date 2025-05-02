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
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_1 -p 27 -st topic344_0_0 -pt topic344_0_1 -u 0.004843445464378149 > ./result_8chains/node344_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_1 -p 266 -st topic344_1_0 -pt topic344_1_1 -u 0.015039651164804935 > ./result_8chains/node344_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_1 -p 515 -st topic344_2_0 -pt topic344_2_1 -u 0.05267081105674809 > ./result_8chains/node344_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_1 -p 626 -st topic344_3_0 -pt topic344_3_1 -u 0.0028301611937193993 > ./result_8chains/node344_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_1 -p 716 -st topic344_4_0 -pt topic344_4_1 -u 0.012204185787756727 > ./result_8chains/node344_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_1 -p 761 -st topic344_5_0 -pt topic344_5_1 -u 0.0010109956867454806 > ./result_8chains/node344_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_1 -p 787 -st topic344_6_0 -pt topic344_6_1 -u 0.026893400314625053 > ./result_8chains/node344_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_1 -p 936 -st topic344_7_0 -pt topic344_7_1 -u 0.022436956477906243 > ./result_8chains/node344_7_1.txt &
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
    "./result_8chains/node344_0_1.txt 90"
    "./result_8chains/node344_1_1.txt 89"
    "./result_8chains/node344_2_1.txt 88"
    "./result_8chains/node344_3_1.txt 87"
    "./result_8chains/node344_4_1.txt 86"
    "./result_8chains/node344_5_1.txt 85"
    "./result_8chains/node344_6_1.txt 84"
    "./result_8chains/node344_7_1.txt 83"
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
