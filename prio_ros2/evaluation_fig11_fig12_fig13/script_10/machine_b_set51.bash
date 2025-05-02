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
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_1 -p 166 -st topic51_0_0 -pt topic51_0_1 -u 0.00025206109354924955 > ./result_10chains/node51_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_1 -p 178 -st topic51_1_0 -pt topic51_1_1 -u 0.0005964062321667796 > ./result_10chains/node51_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_1 -p 246 -st topic51_2_0 -pt topic51_2_1 -u 0.039181769783309006 > ./result_10chains/node51_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_1 -p 261 -st topic51_3_0 -pt topic51_3_1 -u 0.0240835400360227 > ./result_10chains/node51_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_1 -p 453 -st topic51_4_0 -pt topic51_4_1 -u 0.0032362505342679038 > ./result_10chains/node51_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_1 -p 480 -st topic51_5_0 -pt topic51_5_1 -u 0.008249139103444741 > ./result_10chains/node51_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_1 -p 488 -st topic51_6_0 -pt topic51_6_1 -u 0.0020821588457937412 > ./result_10chains/node51_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_1 -p 550 -st topic51_7_0 -pt topic51_7_1 -u 0.006259486571039863 > ./result_10chains/node51_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_8_1 -p 735 -st topic51_8_0 -pt topic51_8_1 -u 0.028899144773208235 > ./result_10chains/node51_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_9_1 -p 909 -st topic51_9_0 -pt topic51_9_1 -u 0.0017536471645100485 > ./result_10chains/node51_9_1.txt &
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
    "./result_10chains/node51_0_1.txt 90"
    "./result_10chains/node51_1_1.txt 89"
    "./result_10chains/node51_2_1.txt 88"
    "./result_10chains/node51_3_1.txt 87"
    "./result_10chains/node51_4_1.txt 86"
    "./result_10chains/node51_5_1.txt 85"
    "./result_10chains/node51_6_1.txt 84"
    "./result_10chains/node51_7_1.txt 83"
    "./result_10chains/node51_8_1.txt 82"
    "./result_10chains/node51_9_1.txt 81"
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
