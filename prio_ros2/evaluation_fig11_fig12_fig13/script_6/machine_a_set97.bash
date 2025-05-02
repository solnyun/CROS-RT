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
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_2 -p 158 -st topic97_0_1 -pt None -u 0.015967173080666586 > ./result_6chains/node97_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_2 -p 182 -st topic97_1_1 -pt None -u 0.07584086208028129 > ./result_6chains/node97_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_2 -p 245 -st topic97_2_1 -pt None -u 0.015504291489840172 > ./result_6chains/node97_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_2 -p 561 -st topic97_3_1 -pt None -u 0.016387994198690192 > ./result_6chains/node97_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_2 -p 584 -st topic97_4_1 -pt None -u 0.021198520988090455 > ./result_6chains/node97_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_2 -p 741 -st topic97_5_1 -pt None -u 0.04849969904997509 > ./result_6chains/node97_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_0 -p 158 -st none -pt topic97_0_0 -u 0.013120581450648316 > ./result_6chains/node97_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_0 -p 182 -st none -pt topic97_1_0 -u 0.006263746743297716 > ./result_6chains/node97_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_0 -p 245 -st none -pt topic97_2_0 -u 0.023313006632604494 > ./result_6chains/node97_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_0 -p 561 -st none -pt topic97_3_0 -u 0.026326872447226618 > ./result_6chains/node97_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_0 -p 584 -st none -pt topic97_4_0 -u 0.028934234983839402 > ./result_6chains/node97_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_0 -p 741 -st none -pt topic97_5_0 -u 0.014747144092013192 > ./result_6chains/node97_5_0.txt &
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
    "./result_6chains/node97_0_0.txt 90"
    "./result_6chains/node97_0_2.txt 90"
    "./result_6chains/node97_1_0.txt 89"
    "./result_6chains/node97_1_2.txt 89"
    "./result_6chains/node97_2_0.txt 88"
    "./result_6chains/node97_2_2.txt 88"
    "./result_6chains/node97_3_0.txt 87"
    "./result_6chains/node97_3_2.txt 87"
    "./result_6chains/node97_4_0.txt 86"
    "./result_6chains/node97_4_2.txt 86"
    "./result_6chains/node97_5_0.txt 85"
    "./result_6chains/node97_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
