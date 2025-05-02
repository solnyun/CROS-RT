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
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_2 -p 254 -st topic172_0_1 -pt None -u 0.030060667933899055 > ./result_6chains/node172_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_2 -p 386 -st topic172_1_1 -pt None -u 0.043600611573739456 > ./result_6chains/node172_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_2 -p 414 -st topic172_2_1 -pt None -u 0.0069191982333884905 > ./result_6chains/node172_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_2 -p 651 -st topic172_3_1 -pt None -u 0.00818564447112724 > ./result_6chains/node172_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_2 -p 864 -st topic172_4_1 -pt None -u 0.04712145254105221 > ./result_6chains/node172_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_2 -p 916 -st topic172_5_1 -pt None -u 0.04809518569989065 > ./result_6chains/node172_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_0 -p 254 -st none -pt topic172_0_0 -u 0.07267857851516674 > ./result_6chains/node172_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_0 -p 386 -st none -pt topic172_1_0 -u 0.037159793559868315 > ./result_6chains/node172_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_0 -p 414 -st none -pt topic172_2_0 -u 0.0002986253233054903 > ./result_6chains/node172_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_0 -p 651 -st none -pt topic172_3_0 -u 0.002376439236314809 > ./result_6chains/node172_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_0 -p 864 -st none -pt topic172_4_0 -u 0.00564070335996697 > ./result_6chains/node172_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_0 -p 916 -st none -pt topic172_5_0 -u 0.032294917129298994 > ./result_6chains/node172_5_0.txt &
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
    "./result_6chains/node172_0_0.txt 90"
    "./result_6chains/node172_0_2.txt 90"
    "./result_6chains/node172_1_0.txt 89"
    "./result_6chains/node172_1_2.txt 89"
    "./result_6chains/node172_2_0.txt 88"
    "./result_6chains/node172_2_2.txt 88"
    "./result_6chains/node172_3_0.txt 87"
    "./result_6chains/node172_3_2.txt 87"
    "./result_6chains/node172_4_0.txt 86"
    "./result_6chains/node172_4_2.txt 86"
    "./result_6chains/node172_5_0.txt 85"
    "./result_6chains/node172_5_2.txt 85"
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
