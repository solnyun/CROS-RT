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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_2 -p 146 -st topic436_0_1 -pt None -u 0.015604744639999946 > ./result_6chains/node436_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_2 -p 268 -st topic436_1_1 -pt None -u 0.09723055526336155 > ./result_6chains/node436_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_2 -p 366 -st topic436_2_1 -pt None -u 0.01020270700746656 > ./result_6chains/node436_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_2 -p 720 -st topic436_3_1 -pt None -u 0.03379278167858227 > ./result_6chains/node436_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_2 -p 765 -st topic436_4_1 -pt None -u 0.008673758345266278 > ./result_6chains/node436_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_2 -p 772 -st topic436_5_1 -pt None -u 0.06098154551673299 > ./result_6chains/node436_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_0 -p 146 -st none -pt topic436_0_0 -u 0.015696001089919254 > ./result_6chains/node436_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_0 -p 268 -st none -pt topic436_1_0 -u 0.011678813795314102 > ./result_6chains/node436_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_0 -p 366 -st none -pt topic436_2_0 -u 0.010088904722561964 > ./result_6chains/node436_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_0 -p 720 -st none -pt topic436_3_0 -u 0.03286817649465901 > ./result_6chains/node436_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_0 -p 765 -st none -pt topic436_4_0 -u 0.015616502468981802 > ./result_6chains/node436_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_0 -p 772 -st none -pt topic436_5_0 -u 0.009424616844747116 > ./result_6chains/node436_5_0.txt &
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
    "./result_6chains/node436_0_0.txt 90"
    "./result_6chains/node436_0_2.txt 90"
    "./result_6chains/node436_1_0.txt 89"
    "./result_6chains/node436_1_2.txt 89"
    "./result_6chains/node436_2_0.txt 88"
    "./result_6chains/node436_2_2.txt 88"
    "./result_6chains/node436_3_0.txt 87"
    "./result_6chains/node436_3_2.txt 87"
    "./result_6chains/node436_4_0.txt 86"
    "./result_6chains/node436_4_2.txt 86"
    "./result_6chains/node436_5_0.txt 85"
    "./result_6chains/node436_5_2.txt 85"
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
