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
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_2 -p 109 -st topic333_0_1 -pt None -u 0.021088921700153362 > ./result_6chains/node333_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_2 -p 198 -st topic333_1_1 -pt None -u 0.004931256767381487 > ./result_6chains/node333_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_2 -p 266 -st topic333_2_1 -pt None -u 0.039111401511053634 > ./result_6chains/node333_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_2 -p 567 -st topic333_3_1 -pt None -u 0.022915780848559664 > ./result_6chains/node333_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_2 -p 827 -st topic333_4_1 -pt None -u 0.007583697621947341 > ./result_6chains/node333_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_2 -p 993 -st topic333_5_1 -pt None -u 0.027121802506154907 > ./result_6chains/node333_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_0 -p 109 -st none -pt topic333_0_0 -u 0.007035314872737841 > ./result_6chains/node333_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_0 -p 198 -st none -pt topic333_1_0 -u 0.0014810585086459382 > ./result_6chains/node333_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_0 -p 266 -st none -pt topic333_2_0 -u 0.006755836301156781 > ./result_6chains/node333_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_0 -p 567 -st none -pt topic333_3_0 -u 0.04116292379406966 > ./result_6chains/node333_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_0 -p 827 -st none -pt topic333_4_0 -u 0.021946999020938968 > ./result_6chains/node333_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_0 -p 993 -st none -pt topic333_5_0 -u 0.04248554852997519 > ./result_6chains/node333_5_0.txt &
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
    "./result_6chains/node333_0_0.txt 90"
    "./result_6chains/node333_0_2.txt 90"
    "./result_6chains/node333_1_0.txt 89"
    "./result_6chains/node333_1_2.txt 89"
    "./result_6chains/node333_2_0.txt 88"
    "./result_6chains/node333_2_2.txt 88"
    "./result_6chains/node333_3_0.txt 87"
    "./result_6chains/node333_3_2.txt 87"
    "./result_6chains/node333_4_0.txt 86"
    "./result_6chains/node333_4_2.txt 86"
    "./result_6chains/node333_5_0.txt 85"
    "./result_6chains/node333_5_2.txt 85"
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
