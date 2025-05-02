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
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_2 -p 182 -st topic239_0_1 -pt None -u 0.028413572880622462 > ./result_6chains/node239_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_2 -p 302 -st topic239_1_1 -pt None -u 0.005806313674422858 > ./result_6chains/node239_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_2 -p 646 -st topic239_2_1 -pt None -u 0.03141956786646899 > ./result_6chains/node239_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_2 -p 656 -st topic239_3_1 -pt None -u 0.01177037029837219 > ./result_6chains/node239_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_2 -p 877 -st topic239_4_1 -pt None -u 0.004656242618246244 > ./result_6chains/node239_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_2 -p 891 -st topic239_5_1 -pt None -u 0.008255984454508179 > ./result_6chains/node239_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_0 -p 182 -st none -pt topic239_0_0 -u 0.07267058373446339 > ./result_6chains/node239_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_0 -p 302 -st none -pt topic239_1_0 -u 0.047247027841664624 > ./result_6chains/node239_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_0 -p 646 -st none -pt topic239_2_0 -u 0.006622038935254815 > ./result_6chains/node239_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_0 -p 656 -st none -pt topic239_3_0 -u 0.05735798534057929 > ./result_6chains/node239_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_0 -p 877 -st none -pt topic239_4_0 -u 0.0869057891046851 > ./result_6chains/node239_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_0 -p 891 -st none -pt topic239_5_0 -u 0.011600560353905706 > ./result_6chains/node239_5_0.txt &
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
    "./result_6chains/node239_0_0.txt 90"
    "./result_6chains/node239_0_2.txt 90"
    "./result_6chains/node239_1_0.txt 89"
    "./result_6chains/node239_1_2.txt 89"
    "./result_6chains/node239_2_0.txt 88"
    "./result_6chains/node239_2_2.txt 88"
    "./result_6chains/node239_3_0.txt 87"
    "./result_6chains/node239_3_2.txt 87"
    "./result_6chains/node239_4_0.txt 86"
    "./result_6chains/node239_4_2.txt 86"
    "./result_6chains/node239_5_0.txt 85"
    "./result_6chains/node239_5_2.txt 85"
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
