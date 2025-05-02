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
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_2 -p 107 -st topic48_0_1 -pt None -u 0.03380891806696934 > ./result_6chains/node48_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_2 -p 283 -st topic48_1_1 -pt None -u 0.038600289988515335 > ./result_6chains/node48_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_2 -p 306 -st topic48_2_1 -pt None -u 0.03522168985992788 > ./result_6chains/node48_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_2 -p 468 -st topic48_3_1 -pt None -u 0.011465089419270436 > ./result_6chains/node48_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_2 -p 602 -st topic48_4_1 -pt None -u 0.013341056659560938 > ./result_6chains/node48_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_2 -p 635 -st topic48_5_1 -pt None -u 0.02227022616195472 > ./result_6chains/node48_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_0 -p 107 -st none -pt topic48_0_0 -u 0.09256309064622736 > ./result_6chains/node48_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_0 -p 283 -st none -pt topic48_1_0 -u 0.0071781644838425085 > ./result_6chains/node48_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_0 -p 306 -st none -pt topic48_2_0 -u 0.016162500986648176 > ./result_6chains/node48_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_0 -p 468 -st none -pt topic48_3_0 -u 0.03743547858694668 > ./result_6chains/node48_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_0 -p 602 -st none -pt topic48_4_0 -u 0.02454178843591387 > ./result_6chains/node48_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_0 -p 635 -st none -pt topic48_5_0 -u 0.005173021110457365 > ./result_6chains/node48_5_0.txt &
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
    "./result_6chains/node48_0_0.txt 90"
    "./result_6chains/node48_0_2.txt 90"
    "./result_6chains/node48_1_0.txt 89"
    "./result_6chains/node48_1_2.txt 89"
    "./result_6chains/node48_2_0.txt 88"
    "./result_6chains/node48_2_2.txt 88"
    "./result_6chains/node48_3_0.txt 87"
    "./result_6chains/node48_3_2.txt 87"
    "./result_6chains/node48_4_0.txt 86"
    "./result_6chains/node48_4_2.txt 86"
    "./result_6chains/node48_5_0.txt 85"
    "./result_6chains/node48_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
