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
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_2 -p 117 -st topic188_0_1 -pt None -u 0.015224837769861832 > ./result_6chains/node188_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_2 -p 266 -st topic188_1_1 -pt None -u 0.03153253883446672 > ./result_6chains/node188_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_2 -p 307 -st topic188_2_1 -pt None -u 0.0034484451527423687 > ./result_6chains/node188_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_2 -p 376 -st topic188_3_1 -pt None -u 0.005668493139520447 > ./result_6chains/node188_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_2 -p 716 -st topic188_4_1 -pt None -u 0.004694565872318979 > ./result_6chains/node188_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_2 -p 718 -st topic188_5_1 -pt None -u 0.057225499059048585 > ./result_6chains/node188_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_0 -p 117 -st none -pt topic188_0_0 -u 0.0543239518698202 > ./result_6chains/node188_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_0 -p 266 -st none -pt topic188_1_0 -u 0.08326793785139563 > ./result_6chains/node188_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_0 -p 307 -st none -pt topic188_2_0 -u 0.04691378961710174 > ./result_6chains/node188_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_0 -p 376 -st none -pt topic188_3_0 -u 0.06469798185930273 > ./result_6chains/node188_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_0 -p 716 -st none -pt topic188_4_0 -u 0.0015378645593399215 > ./result_6chains/node188_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_0 -p 718 -st none -pt topic188_5_0 -u 0.013286277298351593 > ./result_6chains/node188_5_0.txt &
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
    "./result_6chains/node188_0_0.txt 90"
    "./result_6chains/node188_0_2.txt 90"
    "./result_6chains/node188_1_0.txt 89"
    "./result_6chains/node188_1_2.txt 89"
    "./result_6chains/node188_2_0.txt 88"
    "./result_6chains/node188_2_2.txt 88"
    "./result_6chains/node188_3_0.txt 87"
    "./result_6chains/node188_3_2.txt 87"
    "./result_6chains/node188_4_0.txt 86"
    "./result_6chains/node188_4_2.txt 86"
    "./result_6chains/node188_5_0.txt 85"
    "./result_6chains/node188_5_2.txt 85"
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
