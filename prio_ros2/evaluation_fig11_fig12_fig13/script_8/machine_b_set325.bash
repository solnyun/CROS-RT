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
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_1 -p 188 -st topic325_0_0 -pt topic325_0_1 -u 0.027753771592293308 > ./result_8chains/node325_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_1 -p 453 -st topic325_1_0 -pt topic325_1_1 -u 0.009007910155582943 > ./result_8chains/node325_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_1 -p 559 -st topic325_2_0 -pt topic325_2_1 -u 0.05162240023158837 > ./result_8chains/node325_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_1 -p 871 -st topic325_3_0 -pt topic325_3_1 -u 0.0541138941443676 > ./result_8chains/node325_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_1 -p 883 -st topic325_4_0 -pt topic325_4_1 -u 0.014340335659042025 > ./result_8chains/node325_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_1 -p 884 -st topic325_5_0 -pt topic325_5_1 -u 0.05892198742972668 > ./result_8chains/node325_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_6_1 -p 889 -st topic325_6_0 -pt topic325_6_1 -u 0.019723615528206936 > ./result_8chains/node325_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_7_1 -p 982 -st topic325_7_0 -pt topic325_7_1 -u 0.042169325067712066 > ./result_8chains/node325_7_1.txt &
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
    "./result_8chains/node325_0_1.txt 90"
    "./result_8chains/node325_1_1.txt 89"
    "./result_8chains/node325_2_1.txt 88"
    "./result_8chains/node325_3_1.txt 87"
    "./result_8chains/node325_4_1.txt 86"
    "./result_8chains/node325_5_1.txt 85"
    "./result_8chains/node325_6_1.txt 84"
    "./result_8chains/node325_7_1.txt 83"
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
