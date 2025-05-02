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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_2 -p 264 -st topic139_0_1 -pt None -u 0.032901150495413645 > ./result_6chains/node139_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_2 -p 302 -st topic139_1_1 -pt None -u 0.05285808818986293 > ./result_6chains/node139_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_2 -p 328 -st topic139_2_1 -pt None -u 0.04561261376039791 > ./result_6chains/node139_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_2 -p 529 -st topic139_3_1 -pt None -u 0.016665867735550954 > ./result_6chains/node139_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_2 -p 810 -st topic139_4_1 -pt None -u 0.021863152241813594 > ./result_6chains/node139_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_2 -p 914 -st topic139_5_1 -pt None -u 0.06822660290777637 > ./result_6chains/node139_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_0 -p 264 -st none -pt topic139_0_0 -u 0.03038881397669646 > ./result_6chains/node139_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_0 -p 302 -st none -pt topic139_1_0 -u 0.03813156734238371 > ./result_6chains/node139_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_0 -p 328 -st none -pt topic139_2_0 -u 0.013634248401869442 > ./result_6chains/node139_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_0 -p 529 -st none -pt topic139_3_0 -u 0.005501927539783735 > ./result_6chains/node139_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_0 -p 810 -st none -pt topic139_4_0 -u 0.005109782248226613 > ./result_6chains/node139_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_0 -p 914 -st none -pt topic139_5_0 -u 0.031810632802776365 > ./result_6chains/node139_5_0.txt &
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
    "./result_6chains/node139_0_0.txt 90"
    "./result_6chains/node139_0_2.txt 90"
    "./result_6chains/node139_1_0.txt 89"
    "./result_6chains/node139_1_2.txt 89"
    "./result_6chains/node139_2_0.txt 88"
    "./result_6chains/node139_2_2.txt 88"
    "./result_6chains/node139_3_0.txt 87"
    "./result_6chains/node139_3_2.txt 87"
    "./result_6chains/node139_4_0.txt 86"
    "./result_6chains/node139_4_2.txt 86"
    "./result_6chains/node139_5_0.txt 85"
    "./result_6chains/node139_5_2.txt 85"
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
