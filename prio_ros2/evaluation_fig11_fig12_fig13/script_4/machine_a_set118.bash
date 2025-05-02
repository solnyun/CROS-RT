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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_2 -p 395 -st topic118_0_1 -pt None -u 0.08542151229133166 > ./result_4chains/node118_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_2 -p 555 -st topic118_1_1 -pt None -u 0.02023486171135047 > ./result_4chains/node118_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_2 -p 663 -st topic118_2_1 -pt None -u 0.007098048784068514 > ./result_4chains/node118_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_2 -p 932 -st topic118_3_1 -pt None -u 0.0469409813379476 > ./result_4chains/node118_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_0 -p 395 -st none -pt topic118_0_0 -u 0.03542334769565281 > ./result_4chains/node118_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_0 -p 555 -st none -pt topic118_1_0 -u 0.042860816922366096 > ./result_4chains/node118_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_0 -p 663 -st none -pt topic118_2_0 -u 0.026153211193638476 > ./result_4chains/node118_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_0 -p 932 -st none -pt topic118_3_0 -u 0.04268644772282804 > ./result_4chains/node118_3_0.txt &
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
    "./result_4chains/node118_0_0.txt 90"
    "./result_4chains/node118_0_2.txt 90"
    "./result_4chains/node118_1_0.txt 89"
    "./result_4chains/node118_1_2.txt 89"
    "./result_4chains/node118_2_0.txt 88"
    "./result_4chains/node118_2_2.txt 88"
    "./result_4chains/node118_3_0.txt 87"
    "./result_4chains/node118_3_2.txt 87"
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
