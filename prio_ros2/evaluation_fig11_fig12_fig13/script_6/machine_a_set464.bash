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
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_2 -p 161 -st topic464_0_1 -pt None -u 0.019173680370037027 > ./result_6chains/node464_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_2 -p 345 -st topic464_1_1 -pt None -u 0.07521544275138003 > ./result_6chains/node464_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_2 -p 376 -st topic464_2_1 -pt None -u 0.005988114014821744 > ./result_6chains/node464_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_2 -p 442 -st topic464_3_1 -pt None -u 0.014515108503104501 > ./result_6chains/node464_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_2 -p 453 -st topic464_4_1 -pt None -u 0.011853675671831924 > ./result_6chains/node464_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_2 -p 704 -st topic464_5_1 -pt None -u 0.0283810154951913 > ./result_6chains/node464_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_0 -p 161 -st none -pt topic464_0_0 -u 0.00444620877783819 > ./result_6chains/node464_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_0 -p 345 -st none -pt topic464_1_0 -u 0.10095405116686557 > ./result_6chains/node464_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_0 -p 376 -st none -pt topic464_2_0 -u 0.011517534800267515 > ./result_6chains/node464_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_0 -p 442 -st none -pt topic464_3_0 -u 0.0026510642218579294 > ./result_6chains/node464_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_0 -p 453 -st none -pt topic464_4_0 -u 0.014273875484983808 > ./result_6chains/node464_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_0 -p 704 -st none -pt topic464_5_0 -u 0.012374751364994746 > ./result_6chains/node464_5_0.txt &
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
    "./result_6chains/node464_0_0.txt 90"
    "./result_6chains/node464_0_2.txt 90"
    "./result_6chains/node464_1_0.txt 89"
    "./result_6chains/node464_1_2.txt 89"
    "./result_6chains/node464_2_0.txt 88"
    "./result_6chains/node464_2_2.txt 88"
    "./result_6chains/node464_3_0.txt 87"
    "./result_6chains/node464_3_2.txt 87"
    "./result_6chains/node464_4_0.txt 86"
    "./result_6chains/node464_4_2.txt 86"
    "./result_6chains/node464_5_0.txt 85"
    "./result_6chains/node464_5_2.txt 85"
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
