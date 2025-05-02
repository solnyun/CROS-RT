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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_2 -p 256 -st topic74_0_1 -pt None -u 0.025422403306378016 > ./result_4chains/node74_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_2 -p 592 -st topic74_1_1 -pt None -u 0.0035855067711854094 > ./result_4chains/node74_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_2 -p 594 -st topic74_2_1 -pt None -u 0.025782182769904488 > ./result_4chains/node74_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_2 -p 658 -st topic74_3_1 -pt None -u 0.058823792077555274 > ./result_4chains/node74_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_0 -p 256 -st none -pt topic74_0_0 -u 0.10330074427443581 > ./result_4chains/node74_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_0 -p 592 -st none -pt topic74_1_0 -u 0.0010312323829985703 > ./result_4chains/node74_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_0 -p 594 -st none -pt topic74_2_0 -u 0.04533434894324931 > ./result_4chains/node74_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_0 -p 658 -st none -pt topic74_3_0 -u 0.09513844010723915 > ./result_4chains/node74_3_0.txt &
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
    "./result_4chains/node74_0_0.txt 90"
    "./result_4chains/node74_0_2.txt 90"
    "./result_4chains/node74_1_0.txt 89"
    "./result_4chains/node74_1_2.txt 89"
    "./result_4chains/node74_2_0.txt 88"
    "./result_4chains/node74_2_2.txt 88"
    "./result_4chains/node74_3_0.txt 87"
    "./result_4chains/node74_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
