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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_2 -p 256 -st topic375_0_1 -pt None -u 0.02872773806167067 > ./result_4chains/node375_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_2 -p 643 -st topic375_1_1 -pt None -u 0.015634794446990258 > ./result_4chains/node375_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_2 -p 663 -st topic375_2_1 -pt None -u 0.004725554118016312 > ./result_4chains/node375_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_2 -p 821 -st topic375_3_1 -pt None -u 0.08916859027775335 > ./result_4chains/node375_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_0 -p 256 -st none -pt topic375_0_0 -u 0.0019245972804715072 > ./result_4chains/node375_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_0 -p 643 -st none -pt topic375_1_0 -u 0.08076187750762487 > ./result_4chains/node375_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_0 -p 663 -st none -pt topic375_2_0 -u 0.006549478264507885 > ./result_4chains/node375_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_0 -p 821 -st none -pt topic375_3_0 -u 0.04465182921264195 > ./result_4chains/node375_3_0.txt &
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
    "./result_4chains/node375_0_0.txt 90"
    "./result_4chains/node375_0_2.txt 90"
    "./result_4chains/node375_1_0.txt 89"
    "./result_4chains/node375_1_2.txt 89"
    "./result_4chains/node375_2_0.txt 88"
    "./result_4chains/node375_2_2.txt 88"
    "./result_4chains/node375_3_0.txt 87"
    "./result_4chains/node375_3_2.txt 87"
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
