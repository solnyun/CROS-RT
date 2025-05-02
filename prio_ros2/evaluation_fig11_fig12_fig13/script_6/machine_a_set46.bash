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
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_2 -p 46 -st topic46_0_1 -pt None -u 0.01072212613956336 > ./result_6chains/node46_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_2 -p 302 -st topic46_1_1 -pt None -u 0.04827910104097677 > ./result_6chains/node46_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_2 -p 609 -st topic46_2_1 -pt None -u 0.007831072803037298 > ./result_6chains/node46_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_2 -p 619 -st topic46_3_1 -pt None -u 0.021076637110743146 > ./result_6chains/node46_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_2 -p 677 -st topic46_4_1 -pt None -u 0.018865541870313918 > ./result_6chains/node46_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_2 -p 864 -st topic46_5_1 -pt None -u 0.02208069430948245 > ./result_6chains/node46_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_0 -p 46 -st none -pt topic46_0_0 -u 0.012519104587610796 > ./result_6chains/node46_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_0 -p 302 -st none -pt topic46_1_0 -u 0.047289235664112084 > ./result_6chains/node46_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_0 -p 609 -st none -pt topic46_2_0 -u 0.013439286937077799 > ./result_6chains/node46_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_0 -p 619 -st none -pt topic46_3_0 -u 0.014069607285296715 > ./result_6chains/node46_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_0 -p 677 -st none -pt topic46_4_0 -u 0.02292263175729295 > ./result_6chains/node46_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_0 -p 864 -st none -pt topic46_5_0 -u 0.044963629775751676 > ./result_6chains/node46_5_0.txt &
sleep 10
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
    "./result_6chains/node46_0_0.txt 90"
    "./result_6chains/node46_0_2.txt 90"
    "./result_6chains/node46_1_0.txt 89"
    "./result_6chains/node46_1_2.txt 89"
    "./result_6chains/node46_2_0.txt 88"
    "./result_6chains/node46_2_2.txt 88"
    "./result_6chains/node46_3_0.txt 87"
    "./result_6chains/node46_3_2.txt 87"
    "./result_6chains/node46_4_0.txt 86"
    "./result_6chains/node46_4_2.txt 86"
    "./result_6chains/node46_5_0.txt 85"
    "./result_6chains/node46_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
