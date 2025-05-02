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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_1 -p 150 -st topic414_0_0 -pt topic414_0_1 -u 0.0032979447550625096 > ./result_10chains/node414_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_1 -p 287 -st topic414_1_0 -pt topic414_1_1 -u 0.06792213614784703 > ./result_10chains/node414_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_1 -p 289 -st topic414_2_0 -pt topic414_2_1 -u 0.003168803524001229 > ./result_10chains/node414_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_1 -p 419 -st topic414_3_0 -pt topic414_3_1 -u 0.010120882529851716 > ./result_10chains/node414_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_1 -p 437 -st topic414_4_0 -pt topic414_4_1 -u 0.042530029992196905 > ./result_10chains/node414_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_1 -p 658 -st topic414_5_0 -pt topic414_5_1 -u 0.008488229080621301 > ./result_10chains/node414_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_1 -p 780 -st topic414_6_0 -pt topic414_6_1 -u 0.012228352720472652 > ./result_10chains/node414_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_1 -p 786 -st topic414_7_0 -pt topic414_7_1 -u 0.011261331814237774 > ./result_10chains/node414_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_8_1 -p 834 -st topic414_8_0 -pt topic414_8_1 -u 0.0005735748587818654 > ./result_10chains/node414_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_9_1 -p 917 -st topic414_9_0 -pt topic414_9_1 -u 0.009972735735335757 > ./result_10chains/node414_9_1.txt &
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
    "./result_10chains/node414_0_1.txt 90"
    "./result_10chains/node414_1_1.txt 89"
    "./result_10chains/node414_2_1.txt 88"
    "./result_10chains/node414_3_1.txt 87"
    "./result_10chains/node414_4_1.txt 86"
    "./result_10chains/node414_5_1.txt 85"
    "./result_10chains/node414_6_1.txt 84"
    "./result_10chains/node414_7_1.txt 83"
    "./result_10chains/node414_8_1.txt 82"
    "./result_10chains/node414_9_1.txt 81"
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
