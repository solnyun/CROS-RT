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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_1 -p 64 -st topic454_0_0 -pt topic454_0_1 -u 0.00020925339688204758 > ./result_10chains/node454_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_1 -p 343 -st topic454_1_0 -pt topic454_1_1 -u 0.004427783847465783 > ./result_10chains/node454_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_1 -p 397 -st topic454_2_0 -pt topic454_2_1 -u 0.001224959992532526 > ./result_10chains/node454_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_1 -p 478 -st topic454_3_0 -pt topic454_3_1 -u 0.007037952227280986 > ./result_10chains/node454_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_1 -p 666 -st topic454_4_0 -pt topic454_4_1 -u 0.009418175774156268 > ./result_10chains/node454_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_1 -p 744 -st topic454_5_0 -pt topic454_5_1 -u 0.016449400777593604 > ./result_10chains/node454_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_1 -p 849 -st topic454_6_0 -pt topic454_6_1 -u 0.009682227624327078 > ./result_10chains/node454_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_1 -p 936 -st topic454_7_0 -pt topic454_7_1 -u 0.0016660844969406674 > ./result_10chains/node454_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_8_1 -p 956 -st topic454_8_0 -pt topic454_8_1 -u 0.05193170041598866 > ./result_10chains/node454_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_9_1 -p 991 -st topic454_9_0 -pt topic454_9_1 -u 0.023899879888093067 > ./result_10chains/node454_9_1.txt &
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
    "./result_10chains/node454_0_1.txt 90"
    "./result_10chains/node454_1_1.txt 89"
    "./result_10chains/node454_2_1.txt 88"
    "./result_10chains/node454_3_1.txt 87"
    "./result_10chains/node454_4_1.txt 86"
    "./result_10chains/node454_5_1.txt 85"
    "./result_10chains/node454_6_1.txt 84"
    "./result_10chains/node454_7_1.txt 83"
    "./result_10chains/node454_8_1.txt 82"
    "./result_10chains/node454_9_1.txt 81"
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
