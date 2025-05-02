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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_2 -p 34 -st topic499_0_1 -pt None -u 0.03058194382098761 > ./result_4chains/node499_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_2 -p 503 -st topic499_1_1 -pt None -u 0.037525860887395956 > ./result_4chains/node499_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_2 -p 960 -st topic499_2_1 -pt None -u 0.05220101858300594 > ./result_4chains/node499_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_2 -p 965 -st topic499_3_1 -pt None -u 0.03905878447338346 > ./result_4chains/node499_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_0 -p 34 -st none -pt topic499_0_0 -u 0.004357018173038352 > ./result_4chains/node499_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_0 -p 503 -st none -pt topic499_1_0 -u 0.07266157254747813 > ./result_4chains/node499_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_0 -p 960 -st none -pt topic499_2_0 -u 0.007009079031362608 > ./result_4chains/node499_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_0 -p 965 -st none -pt topic499_3_0 -u 0.15194615830809394 > ./result_4chains/node499_3_0.txt &
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
    "./result_4chains/node499_0_0.txt 90"
    "./result_4chains/node499_0_2.txt 90"
    "./result_4chains/node499_1_0.txt 89"
    "./result_4chains/node499_1_2.txt 89"
    "./result_4chains/node499_2_0.txt 88"
    "./result_4chains/node499_2_2.txt 88"
    "./result_4chains/node499_3_0.txt 87"
    "./result_4chains/node499_3_2.txt 87"
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
