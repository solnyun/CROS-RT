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
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_2 -p 10 -st topic149_0_1 -pt None -u 0.024950243761264146 > ./result_10chains/node149_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_2 -p 76 -st topic149_1_1 -pt None -u 0.0167410930752252 > ./result_10chains/node149_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_2 -p 229 -st topic149_2_1 -pt None -u 0.012519828915656672 > ./result_10chains/node149_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_2 -p 256 -st topic149_3_1 -pt None -u 0.034969423303347014 > ./result_10chains/node149_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_2 -p 274 -st topic149_4_1 -pt None -u 0.007392048859950484 > ./result_10chains/node149_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_2 -p 298 -st topic149_5_1 -pt None -u 0.05496031407557578 > ./result_10chains/node149_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_6_2 -p 343 -st topic149_6_1 -pt None -u 0.015370884581193872 > ./result_10chains/node149_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_7_2 -p 498 -st topic149_7_1 -pt None -u 0.005470639215834981 > ./result_10chains/node149_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_8_2 -p 818 -st topic149_8_1 -pt None -u 0.01104913998202266 > ./result_10chains/node149_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_9_2 -p 874 -st topic149_9_1 -pt None -u 0.0002728983451966298 > ./result_10chains/node149_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_0 -p 10 -st none -pt topic149_0_0 -u 0.007338901609887316 > ./result_10chains/node149_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_0 -p 76 -st none -pt topic149_1_0 -u 0.029675700104348612 > ./result_10chains/node149_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_0 -p 229 -st none -pt topic149_2_0 -u 0.014166963971333713 > ./result_10chains/node149_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_0 -p 256 -st none -pt topic149_3_0 -u 0.003354188758333987 > ./result_10chains/node149_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_0 -p 274 -st none -pt topic149_4_0 -u 0.004735817241922513 > ./result_10chains/node149_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_0 -p 298 -st none -pt topic149_5_0 -u 0.012937887226354139 > ./result_10chains/node149_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_6_0 -p 343 -st none -pt topic149_6_0 -u 0.032625123427858976 > ./result_10chains/node149_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_7_0 -p 498 -st none -pt topic149_7_0 -u 0.041142855974242706 > ./result_10chains/node149_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_8_0 -p 818 -st none -pt topic149_8_0 -u 0.016867839491495548 > ./result_10chains/node149_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_9_0 -p 874 -st none -pt topic149_9_0 -u 0.006120758508781578 > ./result_10chains/node149_9_0.txt &
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
    "./result_10chains/node149_0_0.txt 90"
    "./result_10chains/node149_0_2.txt 90"
    "./result_10chains/node149_1_0.txt 89"
    "./result_10chains/node149_1_2.txt 89"
    "./result_10chains/node149_2_0.txt 88"
    "./result_10chains/node149_2_2.txt 88"
    "./result_10chains/node149_3_0.txt 87"
    "./result_10chains/node149_3_2.txt 87"
    "./result_10chains/node149_4_0.txt 86"
    "./result_10chains/node149_4_2.txt 86"
    "./result_10chains/node149_5_0.txt 85"
    "./result_10chains/node149_5_2.txt 85"
    "./result_10chains/node149_6_0.txt 84"
    "./result_10chains/node149_6_2.txt 84"
    "./result_10chains/node149_7_0.txt 83"
    "./result_10chains/node149_7_2.txt 83"
    "./result_10chains/node149_8_0.txt 82"
    "./result_10chains/node149_8_2.txt 82"
    "./result_10chains/node149_9_0.txt 81"
    "./result_10chains/node149_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
