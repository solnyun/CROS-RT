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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_1 -p 32 -st topic189_0_0 -pt topic189_0_1 -u 0.019384781294887077 > ./result_10chains/node189_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_1 -p 39 -st topic189_1_0 -pt topic189_1_1 -u 0.045474239470986 > ./result_10chains/node189_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_1 -p 112 -st topic189_2_0 -pt topic189_2_1 -u 0.012139332273273018 > ./result_10chains/node189_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_1 -p 315 -st topic189_3_0 -pt topic189_3_1 -u 5.676845118601781e-05 > ./result_10chains/node189_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_1 -p 358 -st topic189_4_0 -pt topic189_4_1 -u 0.00986839095270342 > ./result_10chains/node189_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_1 -p 450 -st topic189_5_0 -pt topic189_5_1 -u 0.042674015097568074 > ./result_10chains/node189_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_1 -p 827 -st topic189_6_0 -pt topic189_6_1 -u 0.05063961815846857 > ./result_10chains/node189_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_1 -p 830 -st topic189_7_0 -pt topic189_7_1 -u 0.028159065821255616 > ./result_10chains/node189_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_8_1 -p 897 -st topic189_8_0 -pt topic189_8_1 -u 0.014664553350399429 > ./result_10chains/node189_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_9_1 -p 931 -st topic189_9_0 -pt topic189_9_1 -u 0.0067401325398838835 > ./result_10chains/node189_9_1.txt &
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
    "./result_10chains/node189_0_1.txt 90"
    "./result_10chains/node189_1_1.txt 89"
    "./result_10chains/node189_2_1.txt 88"
    "./result_10chains/node189_3_1.txt 87"
    "./result_10chains/node189_4_1.txt 86"
    "./result_10chains/node189_5_1.txt 85"
    "./result_10chains/node189_6_1.txt 84"
    "./result_10chains/node189_7_1.txt 83"
    "./result_10chains/node189_8_1.txt 82"
    "./result_10chains/node189_9_1.txt 81"
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
