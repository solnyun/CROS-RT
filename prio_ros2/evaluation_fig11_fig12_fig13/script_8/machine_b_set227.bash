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
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_1 -p 45 -st topic227_0_0 -pt topic227_0_1 -u 0.023579756363805715 > ./result_8chains/node227_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_1 -p 211 -st topic227_1_0 -pt topic227_1_1 -u 0.010618314510432603 > ./result_8chains/node227_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_1 -p 229 -st topic227_2_0 -pt topic227_2_1 -u 0.012662673850832806 > ./result_8chains/node227_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_1 -p 335 -st topic227_3_0 -pt topic227_3_1 -u 0.023162340371108203 > ./result_8chains/node227_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_1 -p 755 -st topic227_4_0 -pt topic227_4_1 -u 0.024549932340524827 > ./result_8chains/node227_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_1 -p 898 -st topic227_5_0 -pt topic227_5_1 -u 0.0061020029534728515 > ./result_8chains/node227_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_1 -p 902 -st topic227_6_0 -pt topic227_6_1 -u 0.011931096596179427 > ./result_8chains/node227_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_1 -p 931 -st topic227_7_0 -pt topic227_7_1 -u 0.03063564101108011 > ./result_8chains/node227_7_1.txt &
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
    "./result_8chains/node227_0_1.txt 90"
    "./result_8chains/node227_1_1.txt 89"
    "./result_8chains/node227_2_1.txt 88"
    "./result_8chains/node227_3_1.txt 87"
    "./result_8chains/node227_4_1.txt 86"
    "./result_8chains/node227_5_1.txt 85"
    "./result_8chains/node227_6_1.txt 84"
    "./result_8chains/node227_7_1.txt 83"
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
