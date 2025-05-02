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
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_2 -p 274 -st topic313_0_1 -pt None -u 0.038681231890746126 > ./result_6chains/node313_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_2 -p 392 -st topic313_1_1 -pt None -u 0.08490368062384501 > ./result_6chains/node313_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_2 -p 668 -st topic313_2_1 -pt None -u 0.03620102306515627 > ./result_6chains/node313_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_2 -p 800 -st topic313_3_1 -pt None -u 0.008666688479015736 > ./result_6chains/node313_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_2 -p 850 -st topic313_4_1 -pt None -u 0.030223927755575232 > ./result_6chains/node313_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_2 -p 910 -st topic313_5_1 -pt None -u 0.006434844541182367 > ./result_6chains/node313_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_0 -p 274 -st none -pt topic313_0_0 -u 0.02541879197694752 > ./result_6chains/node313_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_0 -p 392 -st none -pt topic313_1_0 -u 0.023740382806657745 > ./result_6chains/node313_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_0 -p 668 -st none -pt topic313_2_0 -u 0.0018786818457551258 > ./result_6chains/node313_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_0 -p 800 -st none -pt topic313_3_0 -u 0.030594614643067786 > ./result_6chains/node313_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_0 -p 850 -st none -pt topic313_4_0 -u 0.019024011056532883 > ./result_6chains/node313_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_0 -p 910 -st none -pt topic313_5_0 -u 0.0034883406399817546 > ./result_6chains/node313_5_0.txt &
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
    "./result_6chains/node313_0_0.txt 90"
    "./result_6chains/node313_0_2.txt 90"
    "./result_6chains/node313_1_0.txt 89"
    "./result_6chains/node313_1_2.txt 89"
    "./result_6chains/node313_2_0.txt 88"
    "./result_6chains/node313_2_2.txt 88"
    "./result_6chains/node313_3_0.txt 87"
    "./result_6chains/node313_3_2.txt 87"
    "./result_6chains/node313_4_0.txt 86"
    "./result_6chains/node313_4_2.txt 86"
    "./result_6chains/node313_5_0.txt 85"
    "./result_6chains/node313_5_2.txt 85"
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
