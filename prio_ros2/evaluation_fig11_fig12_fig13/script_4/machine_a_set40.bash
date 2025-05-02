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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_2 -p 681 -st topic40_0_1 -pt None -u 0.12886452722326874 > ./result_4chains/node40_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_2 -p 697 -st topic40_1_1 -pt None -u 0.04531436449994042 > ./result_4chains/node40_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_2 -p 795 -st topic40_2_1 -pt None -u 0.0338294467206893 > ./result_4chains/node40_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_2 -p 869 -st topic40_3_1 -pt None -u 0.004179812784796198 > ./result_4chains/node40_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_0 -p 681 -st none -pt topic40_0_0 -u 0.04988140770761823 > ./result_4chains/node40_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_0 -p 697 -st none -pt topic40_1_0 -u 0.0893582431662828 > ./result_4chains/node40_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_0 -p 795 -st none -pt topic40_2_0 -u 0.009876421902981256 > ./result_4chains/node40_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_0 -p 869 -st none -pt topic40_3_0 -u 0.01433460339166815 > ./result_4chains/node40_3_0.txt &
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
    "./result_4chains/node40_0_0.txt 90"
    "./result_4chains/node40_0_2.txt 90"
    "./result_4chains/node40_1_0.txt 89"
    "./result_4chains/node40_1_2.txt 89"
    "./result_4chains/node40_2_0.txt 88"
    "./result_4chains/node40_2_2.txt 88"
    "./result_4chains/node40_3_0.txt 87"
    "./result_4chains/node40_3_2.txt 87"
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
