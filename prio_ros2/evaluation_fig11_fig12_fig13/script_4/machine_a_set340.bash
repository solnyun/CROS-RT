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
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_2 -p 52 -st topic340_0_1 -pt None -u 0.022607690330229302 > ./result_4chains/node340_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_2 -p 421 -st topic340_1_1 -pt None -u 0.009801578457857008 > ./result_4chains/node340_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_2 -p 669 -st topic340_2_1 -pt None -u 0.16966835352252457 > ./result_4chains/node340_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_2 -p 789 -st topic340_3_1 -pt None -u 0.0168505447141485 > ./result_4chains/node340_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_0 -p 52 -st none -pt topic340_0_0 -u 0.001544906806861368 > ./result_4chains/node340_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_0 -p 421 -st none -pt topic340_1_0 -u 0.08347876604647825 > ./result_4chains/node340_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_0 -p 669 -st none -pt topic340_2_0 -u 0.004432311051206672 > ./result_4chains/node340_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_0 -p 789 -st none -pt topic340_3_0 -u 0.042782912924733615 > ./result_4chains/node340_3_0.txt &
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
    "./result_4chains/node340_0_0.txt 90"
    "./result_4chains/node340_0_2.txt 90"
    "./result_4chains/node340_1_0.txt 89"
    "./result_4chains/node340_1_2.txt 89"
    "./result_4chains/node340_2_0.txt 88"
    "./result_4chains/node340_2_2.txt 88"
    "./result_4chains/node340_3_0.txt 87"
    "./result_4chains/node340_3_2.txt 87"
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
