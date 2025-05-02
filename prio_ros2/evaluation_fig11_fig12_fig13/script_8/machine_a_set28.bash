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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_2 -p 152 -st topic28_0_1 -pt None -u 0.018066233496826123 > ./result_8chains/node28_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_2 -p 176 -st topic28_1_1 -pt None -u 0.03305132622404966 > ./result_8chains/node28_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_2 -p 412 -st topic28_2_1 -pt None -u 0.017527721094327375 > ./result_8chains/node28_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_2 -p 474 -st topic28_3_1 -pt None -u 0.07184276563396713 > ./result_8chains/node28_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_2 -p 560 -st topic28_4_1 -pt None -u 0.01281369119747977 > ./result_8chains/node28_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_2 -p 633 -st topic28_5_1 -pt None -u 0.019938542125007508 > ./result_8chains/node28_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_2 -p 761 -st topic28_6_1 -pt None -u 0.02428813349791456 > ./result_8chains/node28_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_2 -p 781 -st topic28_7_1 -pt None -u 0.014104194952039273 > ./result_8chains/node28_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_0 -p 152 -st none -pt topic28_0_0 -u 0.006193304942459121 > ./result_8chains/node28_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_0 -p 176 -st none -pt topic28_1_0 -u 0.023162242168680458 > ./result_8chains/node28_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_0 -p 412 -st none -pt topic28_2_0 -u 0.005237768965315082 > ./result_8chains/node28_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_0 -p 474 -st none -pt topic28_3_0 -u 0.0095437435523259 > ./result_8chains/node28_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_0 -p 560 -st none -pt topic28_4_0 -u 0.022311572189210427 > ./result_8chains/node28_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_0 -p 633 -st none -pt topic28_5_0 -u 0.019414424520917545 > ./result_8chains/node28_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_0 -p 761 -st none -pt topic28_6_0 -u 0.010120242059002638 > ./result_8chains/node28_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_0 -p 781 -st none -pt topic28_7_0 -u 0.00015442321976495005 > ./result_8chains/node28_7_0.txt &
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
    "./result_8chains/node28_0_0.txt 90"
    "./result_8chains/node28_0_2.txt 90"
    "./result_8chains/node28_1_0.txt 89"
    "./result_8chains/node28_1_2.txt 89"
    "./result_8chains/node28_2_0.txt 88"
    "./result_8chains/node28_2_2.txt 88"
    "./result_8chains/node28_3_0.txt 87"
    "./result_8chains/node28_3_2.txt 87"
    "./result_8chains/node28_4_0.txt 86"
    "./result_8chains/node28_4_2.txt 86"
    "./result_8chains/node28_5_0.txt 85"
    "./result_8chains/node28_5_2.txt 85"
    "./result_8chains/node28_6_0.txt 84"
    "./result_8chains/node28_6_2.txt 84"
    "./result_8chains/node28_7_0.txt 83"
    "./result_8chains/node28_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
