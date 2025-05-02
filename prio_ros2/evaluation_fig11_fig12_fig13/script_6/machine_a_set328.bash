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
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_2 -p 31 -st topic328_0_1 -pt None -u 0.002914652104329507 > ./result_6chains/node328_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_2 -p 196 -st topic328_1_1 -pt None -u 0.04644704298076757 > ./result_6chains/node328_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_2 -p 249 -st topic328_2_1 -pt None -u 0.0003998432866224588 > ./result_6chains/node328_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_2 -p 283 -st topic328_3_1 -pt None -u 0.04981035241572904 > ./result_6chains/node328_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_2 -p 416 -st topic328_4_1 -pt None -u 0.031707551100889436 > ./result_6chains/node328_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_2 -p 484 -st topic328_5_1 -pt None -u 0.04484145998721172 > ./result_6chains/node328_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_0 -p 31 -st none -pt topic328_0_0 -u 0.08259562150340949 > ./result_6chains/node328_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_0 -p 196 -st none -pt topic328_1_0 -u 0.0077694713453145825 > ./result_6chains/node328_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_0 -p 249 -st none -pt topic328_2_0 -u 0.013289307711961629 > ./result_6chains/node328_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_0 -p 283 -st none -pt topic328_3_0 -u 0.00044676097102597234 > ./result_6chains/node328_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_0 -p 416 -st none -pt topic328_4_0 -u 0.0444173568051795 > ./result_6chains/node328_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_0 -p 484 -st none -pt topic328_5_0 -u 0.020081562789485044 > ./result_6chains/node328_5_0.txt &
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
    "./result_6chains/node328_0_0.txt 90"
    "./result_6chains/node328_0_2.txt 90"
    "./result_6chains/node328_1_0.txt 89"
    "./result_6chains/node328_1_2.txt 89"
    "./result_6chains/node328_2_0.txt 88"
    "./result_6chains/node328_2_2.txt 88"
    "./result_6chains/node328_3_0.txt 87"
    "./result_6chains/node328_3_2.txt 87"
    "./result_6chains/node328_4_0.txt 86"
    "./result_6chains/node328_4_2.txt 86"
    "./result_6chains/node328_5_0.txt 85"
    "./result_6chains/node328_5_2.txt 85"
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
