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
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_1 -p 55 -st topic204_0_0 -pt topic204_0_1 -u 0.020899600347130842 > ./result_8chains/node204_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_1 -p 118 -st topic204_1_0 -pt topic204_1_1 -u 0.017477754759584685 > ./result_8chains/node204_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_1 -p 137 -st topic204_2_0 -pt topic204_2_1 -u 0.03623337067398985 > ./result_8chains/node204_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_1 -p 301 -st topic204_3_0 -pt topic204_3_1 -u 0.02645298634332971 > ./result_8chains/node204_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_1 -p 410 -st topic204_4_0 -pt topic204_4_1 -u 0.002098120187866842 > ./result_8chains/node204_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_1 -p 511 -st topic204_5_0 -pt topic204_5_1 -u 0.10217001976409858 > ./result_8chains/node204_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_1 -p 951 -st topic204_6_0 -pt topic204_6_1 -u 0.030958659295215282 > ./result_8chains/node204_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_1 -p 990 -st topic204_7_0 -pt topic204_7_1 -u 0.008216376508861789 > ./result_8chains/node204_7_1.txt &
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
    "./result_8chains/node204_0_1.txt 90"
    "./result_8chains/node204_1_1.txt 89"
    "./result_8chains/node204_2_1.txt 88"
    "./result_8chains/node204_3_1.txt 87"
    "./result_8chains/node204_4_1.txt 86"
    "./result_8chains/node204_5_1.txt 85"
    "./result_8chains/node204_6_1.txt 84"
    "./result_8chains/node204_7_1.txt 83"
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
