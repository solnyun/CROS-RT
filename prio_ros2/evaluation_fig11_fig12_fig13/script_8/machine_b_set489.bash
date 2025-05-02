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
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_1 -p 147 -st topic489_0_0 -pt topic489_0_1 -u 0.08099997432148903 > ./result_8chains/node489_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_1 -p 150 -st topic489_1_0 -pt topic489_1_1 -u 0.0003522812646167828 > ./result_8chains/node489_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_1 -p 283 -st topic489_2_0 -pt topic489_2_1 -u 0.007805443383515076 > ./result_8chains/node489_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_1 -p 388 -st topic489_3_0 -pt topic489_3_1 -u 0.024792535786056003 > ./result_8chains/node489_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_1 -p 778 -st topic489_4_0 -pt topic489_4_1 -u 0.011209953709732878 > ./result_8chains/node489_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_1 -p 827 -st topic489_5_0 -pt topic489_5_1 -u 0.05851648531040067 > ./result_8chains/node489_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_1 -p 834 -st topic489_6_0 -pt topic489_6_1 -u 0.007251757853934546 > ./result_8chains/node489_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_1 -p 992 -st topic489_7_0 -pt topic489_7_1 -u 0.007084238653997439 > ./result_8chains/node489_7_1.txt &
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
    "./result_8chains/node489_0_1.txt 90"
    "./result_8chains/node489_1_1.txt 89"
    "./result_8chains/node489_2_1.txt 88"
    "./result_8chains/node489_3_1.txt 87"
    "./result_8chains/node489_4_1.txt 86"
    "./result_8chains/node489_5_1.txt 85"
    "./result_8chains/node489_6_1.txt 84"
    "./result_8chains/node489_7_1.txt 83"
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
