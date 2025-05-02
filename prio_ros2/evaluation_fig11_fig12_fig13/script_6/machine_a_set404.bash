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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_2 -p 343 -st topic404_0_1 -pt None -u 0.022657688325405267 > ./result_6chains/node404_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_2 -p 365 -st topic404_1_1 -pt None -u 0.02023444533886143 > ./result_6chains/node404_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_2 -p 458 -st topic404_2_1 -pt None -u 0.03645141327304807 > ./result_6chains/node404_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_2 -p 820 -st topic404_3_1 -pt None -u 0.008196802977061338 > ./result_6chains/node404_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_2 -p 936 -st topic404_4_1 -pt None -u 0.02633921634140884 > ./result_6chains/node404_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_2 -p 963 -st topic404_5_1 -pt None -u 0.021429288601823807 > ./result_6chains/node404_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_0 -p 343 -st none -pt topic404_0_0 -u 0.09572841144716276 > ./result_6chains/node404_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_0 -p 365 -st none -pt topic404_1_0 -u 0.008029407759425067 > ./result_6chains/node404_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_0 -p 458 -st none -pt topic404_2_0 -u 0.0005955751814220034 > ./result_6chains/node404_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_0 -p 820 -st none -pt topic404_3_0 -u 0.03189681445397338 > ./result_6chains/node404_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_0 -p 936 -st none -pt topic404_4_0 -u 0.02285185512338961 > ./result_6chains/node404_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_0 -p 963 -st none -pt topic404_5_0 -u 0.006660552419051294 > ./result_6chains/node404_5_0.txt &
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
    "./result_6chains/node404_0_0.txt 90"
    "./result_6chains/node404_0_2.txt 90"
    "./result_6chains/node404_1_0.txt 89"
    "./result_6chains/node404_1_2.txt 89"
    "./result_6chains/node404_2_0.txt 88"
    "./result_6chains/node404_2_2.txt 88"
    "./result_6chains/node404_3_0.txt 87"
    "./result_6chains/node404_3_2.txt 87"
    "./result_6chains/node404_4_0.txt 86"
    "./result_6chains/node404_4_2.txt 86"
    "./result_6chains/node404_5_0.txt 85"
    "./result_6chains/node404_5_2.txt 85"
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
