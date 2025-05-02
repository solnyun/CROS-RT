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
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_2 -p 11 -st topic209_0_1 -pt None -u 0.04980465850226523 > ./result_6chains/node209_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_2 -p 565 -st topic209_1_1 -pt None -u 0.0243493221550804 > ./result_6chains/node209_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_2 -p 648 -st topic209_2_1 -pt None -u 0.06275823606525788 > ./result_6chains/node209_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_2 -p 708 -st topic209_3_1 -pt None -u 0.021957915935168368 > ./result_6chains/node209_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_2 -p 740 -st topic209_4_1 -pt None -u 0.014683104236963299 > ./result_6chains/node209_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_2 -p 999 -st topic209_5_1 -pt None -u 0.015460135239796568 > ./result_6chains/node209_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_0 -p 11 -st none -pt topic209_0_0 -u 0.025782739041213143 > ./result_6chains/node209_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_0 -p 565 -st none -pt topic209_1_0 -u 0.07230791937772296 > ./result_6chains/node209_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_0 -p 648 -st none -pt topic209_2_0 -u 0.02172036023852958 > ./result_6chains/node209_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_0 -p 708 -st none -pt topic209_3_0 -u 0.004133810750187261 > ./result_6chains/node209_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_0 -p 740 -st none -pt topic209_4_0 -u 0.02233997080550914 > ./result_6chains/node209_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_0 -p 999 -st none -pt topic209_5_0 -u 0.006659438676622203 > ./result_6chains/node209_5_0.txt &
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
    "./result_6chains/node209_0_0.txt 90"
    "./result_6chains/node209_0_2.txt 90"
    "./result_6chains/node209_1_0.txt 89"
    "./result_6chains/node209_1_2.txt 89"
    "./result_6chains/node209_2_0.txt 88"
    "./result_6chains/node209_2_2.txt 88"
    "./result_6chains/node209_3_0.txt 87"
    "./result_6chains/node209_3_2.txt 87"
    "./result_6chains/node209_4_0.txt 86"
    "./result_6chains/node209_4_2.txt 86"
    "./result_6chains/node209_5_0.txt 85"
    "./result_6chains/node209_5_2.txt 85"
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
