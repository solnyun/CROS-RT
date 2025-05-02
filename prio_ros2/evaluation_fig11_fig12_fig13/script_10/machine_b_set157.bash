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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_1 -p 239 -st topic157_0_0 -pt topic157_0_1 -u 0.005397276179900157 > ./result_10chains/node157_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_1 -p 469 -st topic157_1_0 -pt topic157_1_1 -u 0.008175664405555783 > ./result_10chains/node157_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_1 -p 537 -st topic157_2_0 -pt topic157_2_1 -u 0.035687203543371904 > ./result_10chains/node157_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_1 -p 696 -st topic157_3_0 -pt topic157_3_1 -u 0.010409044254151845 > ./result_10chains/node157_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_1 -p 699 -st topic157_4_0 -pt topic157_4_1 -u 0.008994358176001693 > ./result_10chains/node157_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_1 -p 700 -st topic157_5_0 -pt topic157_5_1 -u 0.00910835571414964 > ./result_10chains/node157_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_1 -p 832 -st topic157_6_0 -pt topic157_6_1 -u 0.0017035547468237933 > ./result_10chains/node157_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_1 -p 863 -st topic157_7_0 -pt topic157_7_1 -u 0.01730965241337956 > ./result_10chains/node157_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_8_1 -p 875 -st topic157_8_0 -pt topic157_8_1 -u 0.0019048152702886567 > ./result_10chains/node157_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_9_1 -p 883 -st topic157_9_0 -pt topic157_9_1 -u 0.10233773857191367 > ./result_10chains/node157_9_1.txt &
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
    "./result_10chains/node157_0_1.txt 90"
    "./result_10chains/node157_1_1.txt 89"
    "./result_10chains/node157_2_1.txt 88"
    "./result_10chains/node157_3_1.txt 87"
    "./result_10chains/node157_4_1.txt 86"
    "./result_10chains/node157_5_1.txt 85"
    "./result_10chains/node157_6_1.txt 84"
    "./result_10chains/node157_7_1.txt 83"
    "./result_10chains/node157_8_1.txt 82"
    "./result_10chains/node157_9_1.txt 81"
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
