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
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_1 -p 25 -st topic287_0_0 -pt topic287_0_1 -u 0.0038107935305968788 > ./result_10chains/node287_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_1 -p 152 -st topic287_1_0 -pt topic287_1_1 -u 0.013855138339441186 > ./result_10chains/node287_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_1 -p 187 -st topic287_2_0 -pt topic287_2_1 -u 0.03622188413011174 > ./result_10chains/node287_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_1 -p 208 -st topic287_3_0 -pt topic287_3_1 -u 0.016508658062476367 > ./result_10chains/node287_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_1 -p 211 -st topic287_4_0 -pt topic287_4_1 -u 0.0009315023921303567 > ./result_10chains/node287_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_1 -p 388 -st topic287_5_0 -pt topic287_5_1 -u 0.004219079702771911 > ./result_10chains/node287_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_1 -p 718 -st topic287_6_0 -pt topic287_6_1 -u 0.0036843267240517508 > ./result_10chains/node287_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_1 -p 726 -st topic287_7_0 -pt topic287_7_1 -u 0.04317529044331184 > ./result_10chains/node287_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_8_1 -p 879 -st topic287_8_0 -pt topic287_8_1 -u 0.030980465233863837 > ./result_10chains/node287_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_9_1 -p 896 -st topic287_9_0 -pt topic287_9_1 -u 0.027138823408342817 > ./result_10chains/node287_9_1.txt &
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
    "./result_10chains/node287_0_1.txt 90"
    "./result_10chains/node287_1_1.txt 89"
    "./result_10chains/node287_2_1.txt 88"
    "./result_10chains/node287_3_1.txt 87"
    "./result_10chains/node287_4_1.txt 86"
    "./result_10chains/node287_5_1.txt 85"
    "./result_10chains/node287_6_1.txt 84"
    "./result_10chains/node287_7_1.txt 83"
    "./result_10chains/node287_8_1.txt 82"
    "./result_10chains/node287_9_1.txt 81"
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
