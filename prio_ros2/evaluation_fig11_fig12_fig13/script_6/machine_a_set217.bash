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
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_2 -p 187 -st topic217_0_1 -pt None -u 0.019305967811155178 > ./result_6chains/node217_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_2 -p 257 -st topic217_1_1 -pt None -u 0.04770864127806396 > ./result_6chains/node217_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_2 -p 266 -st topic217_2_1 -pt None -u 0.011836701009465322 > ./result_6chains/node217_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_2 -p 362 -st topic217_3_1 -pt None -u 0.0015653668579645452 > ./result_6chains/node217_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_2 -p 814 -st topic217_4_1 -pt None -u 0.026015869225850745 > ./result_6chains/node217_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_2 -p 956 -st topic217_5_1 -pt None -u 0.00512932602224981 > ./result_6chains/node217_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_0 -p 187 -st none -pt topic217_0_0 -u 0.05140104561370784 > ./result_6chains/node217_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_0 -p 257 -st none -pt topic217_1_0 -u 0.0038049620202123546 > ./result_6chains/node217_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_0 -p 266 -st none -pt topic217_2_0 -u 0.049687935672647565 > ./result_6chains/node217_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_0 -p 362 -st none -pt topic217_3_0 -u 0.010298352867429805 > ./result_6chains/node217_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_0 -p 814 -st none -pt topic217_4_0 -u 0.00777309426263309 > ./result_6chains/node217_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_0 -p 956 -st none -pt topic217_5_0 -u 0.02430533255494637 > ./result_6chains/node217_5_0.txt &
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
    "./result_6chains/node217_0_0.txt 90"
    "./result_6chains/node217_0_2.txt 90"
    "./result_6chains/node217_1_0.txt 89"
    "./result_6chains/node217_1_2.txt 89"
    "./result_6chains/node217_2_0.txt 88"
    "./result_6chains/node217_2_2.txt 88"
    "./result_6chains/node217_3_0.txt 87"
    "./result_6chains/node217_3_2.txt 87"
    "./result_6chains/node217_4_0.txt 86"
    "./result_6chains/node217_4_2.txt 86"
    "./result_6chains/node217_5_0.txt 85"
    "./result_6chains/node217_5_2.txt 85"
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
