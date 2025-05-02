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
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_1 -p 47 -st topic396_0_0 -pt topic396_0_1 -u 0.0014936260960635717 > ./result_10chains/node396_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_1 -p 56 -st topic396_1_0 -pt topic396_1_1 -u 0.005869325590662111 > ./result_10chains/node396_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_1 -p 337 -st topic396_2_0 -pt topic396_2_1 -u 0.03300642853024799 > ./result_10chains/node396_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_1 -p 381 -st topic396_3_0 -pt topic396_3_1 -u 0.004394939953245636 > ./result_10chains/node396_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_1 -p 403 -st topic396_4_0 -pt topic396_4_1 -u 0.03390883237958292 > ./result_10chains/node396_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_1 -p 580 -st topic396_5_0 -pt topic396_5_1 -u 0.002047918171564328 > ./result_10chains/node396_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_6_1 -p 743 -st topic396_6_0 -pt topic396_6_1 -u 0.008212504613022698 > ./result_10chains/node396_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_7_1 -p 777 -st topic396_7_0 -pt topic396_7_1 -u 0.005501589095920786 > ./result_10chains/node396_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_8_1 -p 987 -st topic396_8_0 -pt topic396_8_1 -u 0.011080131735324156 > ./result_10chains/node396_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_9_1 -p 993 -st topic396_9_0 -pt topic396_9_1 -u 0.013641650202846183 > ./result_10chains/node396_9_1.txt &
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
    "./result_10chains/node396_0_1.txt 90"
    "./result_10chains/node396_1_1.txt 89"
    "./result_10chains/node396_2_1.txt 88"
    "./result_10chains/node396_3_1.txt 87"
    "./result_10chains/node396_4_1.txt 86"
    "./result_10chains/node396_5_1.txt 85"
    "./result_10chains/node396_6_1.txt 84"
    "./result_10chains/node396_7_1.txt 83"
    "./result_10chains/node396_8_1.txt 82"
    "./result_10chains/node396_9_1.txt 81"
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
