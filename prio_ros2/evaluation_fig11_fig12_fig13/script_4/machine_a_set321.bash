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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_2 -p 665 -st topic321_0_1 -pt None -u 0.023532007562628132 > ./result_4chains/node321_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_2 -p 796 -st topic321_1_1 -pt None -u 0.03439251379706304 > ./result_4chains/node321_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_2 -p 808 -st topic321_2_1 -pt None -u 0.03104447307281677 > ./result_4chains/node321_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_2 -p 958 -st topic321_3_1 -pt None -u 0.02489468795271583 > ./result_4chains/node321_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_0 -p 665 -st none -pt topic321_0_0 -u 0.01480565004872697 > ./result_4chains/node321_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_0 -p 796 -st none -pt topic321_1_0 -u 0.0347356207941254 > ./result_4chains/node321_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_0 -p 808 -st none -pt topic321_2_0 -u 0.01686202739477799 > ./result_4chains/node321_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_0 -p 958 -st none -pt topic321_3_0 -u 0.04691160142665729 > ./result_4chains/node321_3_0.txt &
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
    "./result_4chains/node321_0_0.txt 90"
    "./result_4chains/node321_0_2.txt 90"
    "./result_4chains/node321_1_0.txt 89"
    "./result_4chains/node321_1_2.txt 89"
    "./result_4chains/node321_2_0.txt 88"
    "./result_4chains/node321_2_2.txt 88"
    "./result_4chains/node321_3_0.txt 87"
    "./result_4chains/node321_3_2.txt 87"
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
