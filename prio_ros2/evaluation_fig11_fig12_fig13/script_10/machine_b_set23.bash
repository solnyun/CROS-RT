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
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_1 -p 135 -st topic23_0_0 -pt topic23_0_1 -u 0.027457218426890417 > ./result_10chains/node23_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_1 -p 151 -st topic23_1_0 -pt topic23_1_1 -u 0.008537405843073553 > ./result_10chains/node23_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_1 -p 199 -st topic23_2_0 -pt topic23_2_1 -u 0.01850141339806688 > ./result_10chains/node23_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_1 -p 297 -st topic23_3_0 -pt topic23_3_1 -u 0.002431824626723589 > ./result_10chains/node23_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_1 -p 485 -st topic23_4_0 -pt topic23_4_1 -u 0.03140563976177077 > ./result_10chains/node23_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_1 -p 518 -st topic23_5_0 -pt topic23_5_1 -u 0.003995400149705147 > ./result_10chains/node23_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_1 -p 548 -st topic23_6_0 -pt topic23_6_1 -u 0.019101394831619767 > ./result_10chains/node23_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_1 -p 661 -st topic23_7_0 -pt topic23_7_1 -u 0.0006994895488325326 > ./result_10chains/node23_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_8_1 -p 849 -st topic23_8_0 -pt topic23_8_1 -u 0.025099897132886587 > ./result_10chains/node23_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_9_1 -p 935 -st topic23_9_0 -pt topic23_9_1 -u 0.027665653483831397 > ./result_10chains/node23_9_1.txt &
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
    "./result_10chains/node23_0_1.txt 90"
    "./result_10chains/node23_1_1.txt 89"
    "./result_10chains/node23_2_1.txt 88"
    "./result_10chains/node23_3_1.txt 87"
    "./result_10chains/node23_4_1.txt 86"
    "./result_10chains/node23_5_1.txt 85"
    "./result_10chains/node23_6_1.txt 84"
    "./result_10chains/node23_7_1.txt 83"
    "./result_10chains/node23_8_1.txt 82"
    "./result_10chains/node23_9_1.txt 81"
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
