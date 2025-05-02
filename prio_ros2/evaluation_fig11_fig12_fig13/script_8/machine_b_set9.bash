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
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_1 -p 172 -st topic9_0_0 -pt topic9_0_1 -u 0.033529284136051773 > ./result_8chains/node9_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_1 -p 217 -st topic9_1_0 -pt topic9_1_1 -u 0.022816273985650226 > ./result_8chains/node9_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_1 -p 222 -st topic9_2_0 -pt topic9_2_1 -u 0.05199980889181033 > ./result_8chains/node9_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_1 -p 239 -st topic9_3_0 -pt topic9_3_1 -u 0.04272829213426854 > ./result_8chains/node9_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_1 -p 501 -st topic9_4_0 -pt topic9_4_1 -u 0.007278529862614264 > ./result_8chains/node9_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_1 -p 629 -st topic9_5_0 -pt topic9_5_1 -u 0.01696833018651392 > ./result_8chains/node9_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_6_1 -p 728 -st topic9_6_0 -pt topic9_6_1 -u 0.01455433470580575 > ./result_8chains/node9_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_7_1 -p 760 -st topic9_7_0 -pt topic9_7_1 -u 0.018729710486987135 > ./result_8chains/node9_7_1.txt &
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
    "./result_8chains/node9_0_1.txt 90"
    "./result_8chains/node9_1_1.txt 89"
    "./result_8chains/node9_2_1.txt 88"
    "./result_8chains/node9_3_1.txt 87"
    "./result_8chains/node9_4_1.txt 86"
    "./result_8chains/node9_5_1.txt 85"
    "./result_8chains/node9_6_1.txt 84"
    "./result_8chains/node9_7_1.txt 83"
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
