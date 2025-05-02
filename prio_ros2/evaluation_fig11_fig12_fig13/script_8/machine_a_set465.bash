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
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_2 -p 29 -st topic465_0_1 -pt None -u 0.028039847727747702 > ./result_8chains/node465_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_2 -p 56 -st topic465_1_1 -pt None -u 0.0002723949421037375 > ./result_8chains/node465_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_2 -p 82 -st topic465_2_1 -pt None -u 0.007127578425659031 > ./result_8chains/node465_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_2 -p 579 -st topic465_3_1 -pt None -u 0.03603925067169686 > ./result_8chains/node465_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_2 -p 619 -st topic465_4_1 -pt None -u 0.019168956494391015 > ./result_8chains/node465_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_2 -p 640 -st topic465_5_1 -pt None -u 0.013842094246438008 > ./result_8chains/node465_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_6_2 -p 784 -st topic465_6_1 -pt None -u 0.012394358919838276 > ./result_8chains/node465_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_7_2 -p 871 -st topic465_7_1 -pt None -u 0.03148407523409722 > ./result_8chains/node465_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_0 -p 29 -st none -pt topic465_0_0 -u 0.012813216272202499 > ./result_8chains/node465_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_0 -p 56 -st none -pt topic465_1_0 -u 0.015503157546208901 > ./result_8chains/node465_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_0 -p 82 -st none -pt topic465_2_0 -u 0.019857895625535305 > ./result_8chains/node465_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_0 -p 579 -st none -pt topic465_3_0 -u 0.05752660191366271 > ./result_8chains/node465_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_0 -p 619 -st none -pt topic465_4_0 -u 0.006161373308291501 > ./result_8chains/node465_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_0 -p 640 -st none -pt topic465_5_0 -u 0.06942843391950845 > ./result_8chains/node465_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_6_0 -p 784 -st none -pt topic465_6_0 -u 0.006854810472900333 > ./result_8chains/node465_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_7_0 -p 871 -st none -pt topic465_7_0 -u 0.004278666297687382 > ./result_8chains/node465_7_0.txt &
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
    "./result_8chains/node465_0_0.txt 90"
    "./result_8chains/node465_0_2.txt 90"
    "./result_8chains/node465_1_0.txt 89"
    "./result_8chains/node465_1_2.txt 89"
    "./result_8chains/node465_2_0.txt 88"
    "./result_8chains/node465_2_2.txt 88"
    "./result_8chains/node465_3_0.txt 87"
    "./result_8chains/node465_3_2.txt 87"
    "./result_8chains/node465_4_0.txt 86"
    "./result_8chains/node465_4_2.txt 86"
    "./result_8chains/node465_5_0.txt 85"
    "./result_8chains/node465_5_2.txt 85"
    "./result_8chains/node465_6_0.txt 84"
    "./result_8chains/node465_6_2.txt 84"
    "./result_8chains/node465_7_0.txt 83"
    "./result_8chains/node465_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
