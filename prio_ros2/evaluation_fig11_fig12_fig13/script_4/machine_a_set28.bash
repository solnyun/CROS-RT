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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_2 -p 261 -st topic28_0_1 -pt None -u 0.039248579023234975 > ./result_4chains/node28_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_2 -p 551 -st topic28_1_1 -pt None -u 0.038123630750699744 > ./result_4chains/node28_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_2 -p 613 -st topic28_2_1 -pt None -u 0.055776281334660116 > ./result_4chains/node28_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_2 -p 865 -st topic28_3_1 -pt None -u 0.0799319818771411 > ./result_4chains/node28_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_0 -p 261 -st none -pt topic28_0_0 -u 0.029325600307847255 > ./result_4chains/node28_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_0 -p 551 -st none -pt topic28_1_0 -u 0.06437767499954111 > ./result_4chains/node28_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_0 -p 613 -st none -pt topic28_2_0 -u 0.006576935829999575 > ./result_4chains/node28_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_0 -p 865 -st none -pt topic28_3_0 -u 0.06331783603623245 > ./result_4chains/node28_3_0.txt &
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
    "./result_4chains/node28_0_0.txt 90"
    "./result_4chains/node28_0_2.txt 90"
    "./result_4chains/node28_1_0.txt 89"
    "./result_4chains/node28_1_2.txt 89"
    "./result_4chains/node28_2_0.txt 88"
    "./result_4chains/node28_2_2.txt 88"
    "./result_4chains/node28_3_0.txt 87"
    "./result_4chains/node28_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
