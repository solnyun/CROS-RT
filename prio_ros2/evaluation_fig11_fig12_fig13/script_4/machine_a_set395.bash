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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_2 -p 41 -st topic395_0_1 -pt None -u 0.03125036192500574 > ./result_4chains/node395_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_2 -p 87 -st topic395_1_1 -pt None -u 0.008412454451654588 > ./result_4chains/node395_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_2 -p 359 -st topic395_2_1 -pt None -u 0.09800404069515203 > ./result_4chains/node395_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_2 -p 926 -st topic395_3_1 -pt None -u 0.031351120722404924 > ./result_4chains/node395_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_0 -p 41 -st none -pt topic395_0_0 -u 0.048223326962752944 > ./result_4chains/node395_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_0 -p 87 -st none -pt topic395_1_0 -u 0.15591709359122885 > ./result_4chains/node395_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_0 -p 359 -st none -pt topic395_2_0 -u 0.06904362606551759 > ./result_4chains/node395_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_0 -p 926 -st none -pt topic395_3_0 -u 0.013221160848889267 > ./result_4chains/node395_3_0.txt &
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
    "./result_4chains/node395_0_0.txt 90"
    "./result_4chains/node395_0_2.txt 90"
    "./result_4chains/node395_1_0.txt 89"
    "./result_4chains/node395_1_2.txt 89"
    "./result_4chains/node395_2_0.txt 88"
    "./result_4chains/node395_2_2.txt 88"
    "./result_4chains/node395_3_0.txt 87"
    "./result_4chains/node395_3_2.txt 87"
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
