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
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_2 -p 184 -st topic311_0_1 -pt None -u 0.03486989820976172 > ./result_6chains/node311_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_2 -p 287 -st topic311_1_1 -pt None -u 0.01990635943556135 > ./result_6chains/node311_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_2 -p 426 -st topic311_2_1 -pt None -u 0.023866983494803817 > ./result_6chains/node311_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_2 -p 732 -st topic311_3_1 -pt None -u 0.002832949118951378 > ./result_6chains/node311_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_2 -p 809 -st topic311_4_1 -pt None -u 0.06076349896894836 > ./result_6chains/node311_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_2 -p 951 -st topic311_5_1 -pt None -u 0.007100600369940079 > ./result_6chains/node311_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_0 -p 184 -st none -pt topic311_0_0 -u 0.012718959759784931 > ./result_6chains/node311_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_0 -p 287 -st none -pt topic311_1_0 -u 0.0331136378516223 > ./result_6chains/node311_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_0 -p 426 -st none -pt topic311_2_0 -u 0.059757962163413586 > ./result_6chains/node311_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_0 -p 732 -st none -pt topic311_3_0 -u 0.008903523778812816 > ./result_6chains/node311_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_0 -p 809 -st none -pt topic311_4_0 -u 0.011065167190667885 > ./result_6chains/node311_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_0 -p 951 -st none -pt topic311_5_0 -u 0.03555375487584438 > ./result_6chains/node311_5_0.txt &
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
    "./result_6chains/node311_0_0.txt 90"
    "./result_6chains/node311_0_2.txt 90"
    "./result_6chains/node311_1_0.txt 89"
    "./result_6chains/node311_1_2.txt 89"
    "./result_6chains/node311_2_0.txt 88"
    "./result_6chains/node311_2_2.txt 88"
    "./result_6chains/node311_3_0.txt 87"
    "./result_6chains/node311_3_2.txt 87"
    "./result_6chains/node311_4_0.txt 86"
    "./result_6chains/node311_4_2.txt 86"
    "./result_6chains/node311_5_0.txt 85"
    "./result_6chains/node311_5_2.txt 85"
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
