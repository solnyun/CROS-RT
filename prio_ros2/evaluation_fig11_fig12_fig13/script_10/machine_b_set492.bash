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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_1 -p 13 -st topic492_0_0 -pt topic492_0_1 -u 0.030605009362988767 > ./result_10chains/node492_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_1 -p 200 -st topic492_1_0 -pt topic492_1_1 -u 0.006135014886821111 > ./result_10chains/node492_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_1 -p 266 -st topic492_2_0 -pt topic492_2_1 -u 0.03339706728777436 > ./result_10chains/node492_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_1 -p 455 -st topic492_3_0 -pt topic492_3_1 -u 0.04022289953658542 > ./result_10chains/node492_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_1 -p 500 -st topic492_4_0 -pt topic492_4_1 -u 0.006111974741567522 > ./result_10chains/node492_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_1 -p 574 -st topic492_5_0 -pt topic492_5_1 -u 0.07703244666514572 > ./result_10chains/node492_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_1 -p 706 -st topic492_6_0 -pt topic492_6_1 -u 0.017489966066136564 > ./result_10chains/node492_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_1 -p 738 -st topic492_7_0 -pt topic492_7_1 -u 0.0024661003991898606 > ./result_10chains/node492_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_8_1 -p 899 -st topic492_8_0 -pt topic492_8_1 -u 0.0018365266357173865 > ./result_10chains/node492_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_9_1 -p 909 -st topic492_9_0 -pt topic492_9_1 -u 0.0011754278985756962 > ./result_10chains/node492_9_1.txt &
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
    "./result_10chains/node492_0_1.txt 90"
    "./result_10chains/node492_1_1.txt 89"
    "./result_10chains/node492_2_1.txt 88"
    "./result_10chains/node492_3_1.txt 87"
    "./result_10chains/node492_4_1.txt 86"
    "./result_10chains/node492_5_1.txt 85"
    "./result_10chains/node492_6_1.txt 84"
    "./result_10chains/node492_7_1.txt 83"
    "./result_10chains/node492_8_1.txt 82"
    "./result_10chains/node492_9_1.txt 81"
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
