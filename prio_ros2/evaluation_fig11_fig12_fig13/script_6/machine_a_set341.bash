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
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_2 -p 44 -st topic341_0_1 -pt None -u 0.01430218855526294 > ./result_6chains/node341_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_2 -p 229 -st topic341_1_1 -pt None -u 0.0452689681117478 > ./result_6chains/node341_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_2 -p 273 -st topic341_2_1 -pt None -u 0.028694320687046665 > ./result_6chains/node341_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_2 -p 432 -st topic341_3_1 -pt None -u 0.03514546938586932 > ./result_6chains/node341_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_2 -p 477 -st topic341_4_1 -pt None -u 0.02269250508308701 > ./result_6chains/node341_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_2 -p 698 -st topic341_5_1 -pt None -u 0.02299085409346082 > ./result_6chains/node341_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_0 -p 44 -st none -pt topic341_0_0 -u 0.018598151899908044 > ./result_6chains/node341_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_0 -p 229 -st none -pt topic341_1_0 -u 0.05931154814782724 > ./result_6chains/node341_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_0 -p 273 -st none -pt topic341_2_0 -u 0.007269806119897859 > ./result_6chains/node341_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_0 -p 432 -st none -pt topic341_3_0 -u 0.05521315885252803 > ./result_6chains/node341_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_0 -p 477 -st none -pt topic341_4_0 -u 0.010455106128567426 > ./result_6chains/node341_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_0 -p 698 -st none -pt topic341_5_0 -u 0.04336338120495567 > ./result_6chains/node341_5_0.txt &
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
    "./result_6chains/node341_0_0.txt 90"
    "./result_6chains/node341_0_2.txt 90"
    "./result_6chains/node341_1_0.txt 89"
    "./result_6chains/node341_1_2.txt 89"
    "./result_6chains/node341_2_0.txt 88"
    "./result_6chains/node341_2_2.txt 88"
    "./result_6chains/node341_3_0.txt 87"
    "./result_6chains/node341_3_2.txt 87"
    "./result_6chains/node341_4_0.txt 86"
    "./result_6chains/node341_4_2.txt 86"
    "./result_6chains/node341_5_0.txt 85"
    "./result_6chains/node341_5_2.txt 85"
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
