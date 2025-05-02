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
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_2 -p 162 -st topic332_0_1 -pt None -u 0.011768262418586306 > ./result_6chains/node332_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_2 -p 273 -st topic332_1_1 -pt None -u 0.02426513791474827 > ./result_6chains/node332_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_2 -p 337 -st topic332_2_1 -pt None -u 0.11322750167965626 > ./result_6chains/node332_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_2 -p 634 -st topic332_3_1 -pt None -u 0.011839391204607558 > ./result_6chains/node332_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_4_2 -p 641 -st topic332_4_1 -pt None -u 0.01565479334294051 > ./result_6chains/node332_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_5_2 -p 646 -st topic332_5_1 -pt None -u 0.031559771321381415 > ./result_6chains/node332_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_0 -p 162 -st none -pt topic332_0_0 -u 0.0015056303098385238 > ./result_6chains/node332_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_0 -p 273 -st none -pt topic332_1_0 -u 0.03162047449117278 > ./result_6chains/node332_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_0 -p 337 -st none -pt topic332_2_0 -u 0.0023027966556183888 > ./result_6chains/node332_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_0 -p 634 -st none -pt topic332_3_0 -u 0.08758589112259677 > ./result_6chains/node332_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_4_0 -p 641 -st none -pt topic332_4_0 -u 0.01645354038114709 > ./result_6chains/node332_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_5_0 -p 646 -st none -pt topic332_5_0 -u 0.03629726871935045 > ./result_6chains/node332_5_0.txt &
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
    "./result_6chains/node332_0_0.txt 90"
    "./result_6chains/node332_0_2.txt 90"
    "./result_6chains/node332_1_0.txt 89"
    "./result_6chains/node332_1_2.txt 89"
    "./result_6chains/node332_2_0.txt 88"
    "./result_6chains/node332_2_2.txt 88"
    "./result_6chains/node332_3_0.txt 87"
    "./result_6chains/node332_3_2.txt 87"
    "./result_6chains/node332_4_0.txt 86"
    "./result_6chains/node332_4_2.txt 86"
    "./result_6chains/node332_5_0.txt 85"
    "./result_6chains/node332_5_2.txt 85"
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
