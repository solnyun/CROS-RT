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
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_2 -p 76 -st topic273_0_1 -pt None -u 0.021520209840552862 > ./result_6chains/node273_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_2 -p 111 -st topic273_1_1 -pt None -u 0.006396701549666706 > ./result_6chains/node273_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_2 -p 479 -st topic273_2_1 -pt None -u 0.006662908175121829 > ./result_6chains/node273_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_2 -p 686 -st topic273_3_1 -pt None -u 0.030069254353559505 > ./result_6chains/node273_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_2 -p 728 -st topic273_4_1 -pt None -u 0.04819396366490458 > ./result_6chains/node273_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_2 -p 798 -st topic273_5_1 -pt None -u 0.015243513698835854 > ./result_6chains/node273_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_0 -p 76 -st none -pt topic273_0_0 -u 0.007054293351964502 > ./result_6chains/node273_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_0 -p 111 -st none -pt topic273_1_0 -u 0.0008487406352717386 > ./result_6chains/node273_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_0 -p 479 -st none -pt topic273_2_0 -u 0.007503902047762689 > ./result_6chains/node273_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_0 -p 686 -st none -pt topic273_3_0 -u 0.005556398726126788 > ./result_6chains/node273_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_0 -p 728 -st none -pt topic273_4_0 -u 0.019602230830701978 > ./result_6chains/node273_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_0 -p 798 -st none -pt topic273_5_0 -u 0.071983071253314 > ./result_6chains/node273_5_0.txt &
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
    "./result_6chains/node273_0_0.txt 90"
    "./result_6chains/node273_0_2.txt 90"
    "./result_6chains/node273_1_0.txt 89"
    "./result_6chains/node273_1_2.txt 89"
    "./result_6chains/node273_2_0.txt 88"
    "./result_6chains/node273_2_2.txt 88"
    "./result_6chains/node273_3_0.txt 87"
    "./result_6chains/node273_3_2.txt 87"
    "./result_6chains/node273_4_0.txt 86"
    "./result_6chains/node273_4_2.txt 86"
    "./result_6chains/node273_5_0.txt 85"
    "./result_6chains/node273_5_2.txt 85"
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
