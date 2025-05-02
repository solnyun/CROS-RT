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
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_2 -p 12 -st topic10_0_1 -pt None -u 0.032100496976623594 > ./result_4chains/node10_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_2 -p 307 -st topic10_1_1 -pt None -u 0.003282697443923288 > ./result_4chains/node10_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_2 -p 637 -st topic10_2_1 -pt None -u 0.011143672535156246 > ./result_4chains/node10_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_2 -p 940 -st topic10_3_1 -pt None -u 0.04229634411947322 > ./result_4chains/node10_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_0 -p 12 -st none -pt topic10_0_0 -u 0.030285206818882637 > ./result_4chains/node10_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_0 -p 307 -st none -pt topic10_1_0 -u 0.020802390103107693 > ./result_4chains/node10_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_0 -p 637 -st none -pt topic10_2_0 -u 0.05469364949504302 > ./result_4chains/node10_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_0 -p 940 -st none -pt topic10_3_0 -u 0.04416207089145137 > ./result_4chains/node10_3_0.txt &
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
    "./result_4chains/node10_0_0.txt 90"
    "./result_4chains/node10_0_2.txt 90"
    "./result_4chains/node10_1_0.txt 89"
    "./result_4chains/node10_1_2.txt 89"
    "./result_4chains/node10_2_0.txt 88"
    "./result_4chains/node10_2_2.txt 88"
    "./result_4chains/node10_3_0.txt 87"
    "./result_4chains/node10_3_2.txt 87"
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
