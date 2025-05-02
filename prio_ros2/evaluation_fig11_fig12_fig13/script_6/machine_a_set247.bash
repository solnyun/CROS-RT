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
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_2 -p 38 -st topic247_0_1 -pt None -u 0.0376253542465666 > ./result_6chains/node247_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_2 -p 202 -st topic247_1_1 -pt None -u 0.00587246467620256 > ./result_6chains/node247_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_2 -p 463 -st topic247_2_1 -pt None -u 0.0738146441111899 > ./result_6chains/node247_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_2 -p 569 -st topic247_3_1 -pt None -u 0.020991362372894756 > ./result_6chains/node247_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_2 -p 726 -st topic247_4_1 -pt None -u 0.022046197917798875 > ./result_6chains/node247_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_2 -p 774 -st topic247_5_1 -pt None -u 0.026188743424193146 > ./result_6chains/node247_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_0 -p 38 -st none -pt topic247_0_0 -u 0.013225858281374347 > ./result_6chains/node247_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_0 -p 202 -st none -pt topic247_1_0 -u 0.047582440683685 > ./result_6chains/node247_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_0 -p 463 -st none -pt topic247_2_0 -u 0.0778648205751859 > ./result_6chains/node247_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_0 -p 569 -st none -pt topic247_3_0 -u 0.04970073424081231 > ./result_6chains/node247_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_0 -p 726 -st none -pt topic247_4_0 -u 0.021646205947035438 > ./result_6chains/node247_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_0 -p 774 -st none -pt topic247_5_0 -u 0.022278457914535074 > ./result_6chains/node247_5_0.txt &
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
    "./result_6chains/node247_0_0.txt 90"
    "./result_6chains/node247_0_2.txt 90"
    "./result_6chains/node247_1_0.txt 89"
    "./result_6chains/node247_1_2.txt 89"
    "./result_6chains/node247_2_0.txt 88"
    "./result_6chains/node247_2_2.txt 88"
    "./result_6chains/node247_3_0.txt 87"
    "./result_6chains/node247_3_2.txt 87"
    "./result_6chains/node247_4_0.txt 86"
    "./result_6chains/node247_4_2.txt 86"
    "./result_6chains/node247_5_0.txt 85"
    "./result_6chains/node247_5_2.txt 85"
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
