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
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_1 -p 24 -st topic168_0_0 -pt topic168_0_1 -u 0.002377469650071795 > ./result_8chains/node168_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_1 -p 55 -st topic168_1_0 -pt topic168_1_1 -u 0.004930854578367838 > ./result_8chains/node168_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_1 -p 177 -st topic168_2_0 -pt topic168_2_1 -u 0.01668683307223806 > ./result_8chains/node168_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_1 -p 181 -st topic168_3_0 -pt topic168_3_1 -u 0.0035240239760621628 > ./result_8chains/node168_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_1 -p 356 -st topic168_4_0 -pt topic168_4_1 -u 0.02559662846701391 > ./result_8chains/node168_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_1 -p 626 -st topic168_5_0 -pt topic168_5_1 -u 0.007376976641893768 > ./result_8chains/node168_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_6_1 -p 775 -st topic168_6_0 -pt topic168_6_1 -u 0.030611994065838977 > ./result_8chains/node168_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_7_1 -p 989 -st topic168_7_0 -pt topic168_7_1 -u 0.01348600543864487 > ./result_8chains/node168_7_1.txt &
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
    "./result_8chains/node168_0_1.txt 90"
    "./result_8chains/node168_1_1.txt 89"
    "./result_8chains/node168_2_1.txt 88"
    "./result_8chains/node168_3_1.txt 87"
    "./result_8chains/node168_4_1.txt 86"
    "./result_8chains/node168_5_1.txt 85"
    "./result_8chains/node168_6_1.txt 84"
    "./result_8chains/node168_7_1.txt 83"
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
