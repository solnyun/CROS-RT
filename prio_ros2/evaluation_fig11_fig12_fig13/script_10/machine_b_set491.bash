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
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_1 -p 66 -st topic491_0_0 -pt topic491_0_1 -u 0.0016611060518460508 > ./result_10chains/node491_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_1 -p 154 -st topic491_1_0 -pt topic491_1_1 -u 0.03809724332670039 > ./result_10chains/node491_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_1 -p 426 -st topic491_2_0 -pt topic491_2_1 -u 0.02940239617618301 > ./result_10chains/node491_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_1 -p 470 -st topic491_3_0 -pt topic491_3_1 -u 0.03200112211210371 > ./result_10chains/node491_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_1 -p 612 -st topic491_4_0 -pt topic491_4_1 -u 0.0031870544789373567 > ./result_10chains/node491_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_1 -p 643 -st topic491_5_0 -pt topic491_5_1 -u 0.025301913940050547 > ./result_10chains/node491_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_6_1 -p 886 -st topic491_6_0 -pt topic491_6_1 -u 0.01107075014617992 > ./result_10chains/node491_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_7_1 -p 893 -st topic491_7_0 -pt topic491_7_1 -u 0.011263494265592547 > ./result_10chains/node491_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_8_1 -p 945 -st topic491_8_0 -pt topic491_8_1 -u 0.002783420837916245 > ./result_10chains/node491_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_9_1 -p 973 -st topic491_9_0 -pt topic491_9_1 -u 0.009396882299844207 > ./result_10chains/node491_9_1.txt &
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
    "./result_10chains/node491_0_1.txt 90"
    "./result_10chains/node491_1_1.txt 89"
    "./result_10chains/node491_2_1.txt 88"
    "./result_10chains/node491_3_1.txt 87"
    "./result_10chains/node491_4_1.txt 86"
    "./result_10chains/node491_5_1.txt 85"
    "./result_10chains/node491_6_1.txt 84"
    "./result_10chains/node491_7_1.txt 83"
    "./result_10chains/node491_8_1.txt 82"
    "./result_10chains/node491_9_1.txt 81"
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
