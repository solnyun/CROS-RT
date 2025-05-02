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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_2 -p 234 -st topic49_0_1 -pt None -u 0.0439080181112273 > ./result_4chains/node49_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_2 -p 332 -st topic49_1_1 -pt None -u 0.04787750556815773 > ./result_4chains/node49_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_2 -p 514 -st topic49_2_1 -pt None -u 0.13951681718732586 > ./result_4chains/node49_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_2 -p 581 -st topic49_3_1 -pt None -u 0.05074392835782872 > ./result_4chains/node49_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_0 -p 234 -st none -pt topic49_0_0 -u 0.012064693546281147 > ./result_4chains/node49_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_0 -p 332 -st none -pt topic49_1_0 -u 0.011113153602558823 > ./result_4chains/node49_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_0 -p 514 -st none -pt topic49_2_0 -u 0.0010654375988739528 > ./result_4chains/node49_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_0 -p 581 -st none -pt topic49_3_0 -u 0.08393342156430329 > ./result_4chains/node49_3_0.txt &
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
    "./result_4chains/node49_0_0.txt 90"
    "./result_4chains/node49_0_2.txt 90"
    "./result_4chains/node49_1_0.txt 89"
    "./result_4chains/node49_1_2.txt 89"
    "./result_4chains/node49_2_0.txt 88"
    "./result_4chains/node49_2_2.txt 88"
    "./result_4chains/node49_3_0.txt 87"
    "./result_4chains/node49_3_2.txt 87"
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
