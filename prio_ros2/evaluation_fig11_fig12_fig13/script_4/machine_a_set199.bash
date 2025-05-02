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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_2 -p 201 -st topic199_0_1 -pt None -u 0.0027359377085501846 > ./result_4chains/node199_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_2 -p 424 -st topic199_1_1 -pt None -u 0.02586902674105851 > ./result_4chains/node199_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_2 -p 707 -st topic199_2_1 -pt None -u 0.048513400415776814 > ./result_4chains/node199_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_2 -p 909 -st topic199_3_1 -pt None -u 0.0722659719509103 > ./result_4chains/node199_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_0 -p 201 -st none -pt topic199_0_0 -u 0.05892111632528463 > ./result_4chains/node199_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_0 -p 424 -st none -pt topic199_1_0 -u 0.1262326655721791 > ./result_4chains/node199_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_0 -p 707 -st none -pt topic199_2_0 -u 3.480020647544935e-05 > ./result_4chains/node199_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_0 -p 909 -st none -pt topic199_3_0 -u 0.08243494185084965 > ./result_4chains/node199_3_0.txt &
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
    "./result_4chains/node199_0_0.txt 90"
    "./result_4chains/node199_0_2.txt 90"
    "./result_4chains/node199_1_0.txt 89"
    "./result_4chains/node199_1_2.txt 89"
    "./result_4chains/node199_2_0.txt 88"
    "./result_4chains/node199_2_2.txt 88"
    "./result_4chains/node199_3_0.txt 87"
    "./result_4chains/node199_3_2.txt 87"
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
