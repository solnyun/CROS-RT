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
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_2 -p 251 -st topic374_0_1 -pt None -u 0.010285076014343975 > ./result_6chains/node374_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_2 -p 276 -st topic374_1_1 -pt None -u 0.012186219612921267 > ./result_6chains/node374_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_2 -p 532 -st topic374_2_1 -pt None -u 0.0030195050217782238 > ./result_6chains/node374_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_2 -p 704 -st topic374_3_1 -pt None -u 0.01663537773946394 > ./result_6chains/node374_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_2 -p 725 -st topic374_4_1 -pt None -u 0.04516163495298571 > ./result_6chains/node374_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_2 -p 766 -st topic374_5_1 -pt None -u 0.024664128294485957 > ./result_6chains/node374_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_0 -p 251 -st none -pt topic374_0_0 -u 0.011981545902983226 > ./result_6chains/node374_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_0 -p 276 -st none -pt topic374_1_0 -u 0.01433280231167583 > ./result_6chains/node374_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_0 -p 532 -st none -pt topic374_2_0 -u 0.024055390331969073 > ./result_6chains/node374_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_0 -p 704 -st none -pt topic374_3_0 -u 0.07331935800930961 > ./result_6chains/node374_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_0 -p 725 -st none -pt topic374_4_0 -u 0.11948341264393245 > ./result_6chains/node374_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_0 -p 766 -st none -pt topic374_5_0 -u 0.03439308753889676 > ./result_6chains/node374_5_0.txt &
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
    "./result_6chains/node374_0_0.txt 90"
    "./result_6chains/node374_0_2.txt 90"
    "./result_6chains/node374_1_0.txt 89"
    "./result_6chains/node374_1_2.txt 89"
    "./result_6chains/node374_2_0.txt 88"
    "./result_6chains/node374_2_2.txt 88"
    "./result_6chains/node374_3_0.txt 87"
    "./result_6chains/node374_3_2.txt 87"
    "./result_6chains/node374_4_0.txt 86"
    "./result_6chains/node374_4_2.txt 86"
    "./result_6chains/node374_5_0.txt 85"
    "./result_6chains/node374_5_2.txt 85"
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
