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
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_2 -p 88 -st topic362_0_1 -pt None -u 0.005348770121163804 > ./result_6chains/node362_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_2 -p 188 -st topic362_1_1 -pt None -u 0.007732722167429096 > ./result_6chains/node362_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_2 -p 372 -st topic362_2_1 -pt None -u 0.07189647881094491 > ./result_6chains/node362_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_2 -p 728 -st topic362_3_1 -pt None -u 0.030963766271118826 > ./result_6chains/node362_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_2 -p 796 -st topic362_4_1 -pt None -u 0.011497445005122347 > ./result_6chains/node362_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_2 -p 807 -st topic362_5_1 -pt None -u 0.001960297996548887 > ./result_6chains/node362_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_0 -p 88 -st none -pt topic362_0_0 -u 0.03800222831804084 > ./result_6chains/node362_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_0 -p 188 -st none -pt topic362_1_0 -u 0.12136469786306614 > ./result_6chains/node362_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_0 -p 372 -st none -pt topic362_2_0 -u 0.03380522432915922 > ./result_6chains/node362_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_0 -p 728 -st none -pt topic362_3_0 -u 0.05295304948613774 > ./result_6chains/node362_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_0 -p 796 -st none -pt topic362_4_0 -u 0.03849308072404952 > ./result_6chains/node362_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_0 -p 807 -st none -pt topic362_5_0 -u 0.00780567513066972 > ./result_6chains/node362_5_0.txt &
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
    "./result_6chains/node362_0_0.txt 90"
    "./result_6chains/node362_0_2.txt 90"
    "./result_6chains/node362_1_0.txt 89"
    "./result_6chains/node362_1_2.txt 89"
    "./result_6chains/node362_2_0.txt 88"
    "./result_6chains/node362_2_2.txt 88"
    "./result_6chains/node362_3_0.txt 87"
    "./result_6chains/node362_3_2.txt 87"
    "./result_6chains/node362_4_0.txt 86"
    "./result_6chains/node362_4_2.txt 86"
    "./result_6chains/node362_5_0.txt 85"
    "./result_6chains/node362_5_2.txt 85"
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
