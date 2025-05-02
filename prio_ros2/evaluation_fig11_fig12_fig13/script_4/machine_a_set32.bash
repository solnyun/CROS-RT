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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_2 -p 218 -st topic32_0_1 -pt None -u 0.10469250131595814 > ./result_4chains/node32_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_2 -p 420 -st topic32_1_1 -pt None -u 0.032864993567483236 > ./result_4chains/node32_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_2 -p 642 -st topic32_2_1 -pt None -u 0.004210314495297934 > ./result_4chains/node32_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_2 -p 811 -st topic32_3_1 -pt None -u 0.08981076999319179 > ./result_4chains/node32_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_0 -p 218 -st none -pt topic32_0_0 -u 0.003135265746700422 > ./result_4chains/node32_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_0 -p 420 -st none -pt topic32_1_0 -u 0.06563747828355387 > ./result_4chains/node32_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_0 -p 642 -st none -pt topic32_2_0 -u 0.0006844051083764735 > ./result_4chains/node32_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_0 -p 811 -st none -pt topic32_3_0 -u 0.04256876503645762 > ./result_4chains/node32_3_0.txt &
sleep 10
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
    "./result_4chains/node32_0_0.txt 90"
    "./result_4chains/node32_0_2.txt 90"
    "./result_4chains/node32_1_0.txt 89"
    "./result_4chains/node32_1_2.txt 89"
    "./result_4chains/node32_2_0.txt 88"
    "./result_4chains/node32_2_2.txt 88"
    "./result_4chains/node32_3_0.txt 87"
    "./result_4chains/node32_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
