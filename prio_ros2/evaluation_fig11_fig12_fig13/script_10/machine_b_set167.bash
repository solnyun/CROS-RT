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
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_1 -p 15 -st topic167_0_0 -pt topic167_0_1 -u 0.00011231328892286063 > ./result_10chains/node167_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_1 -p 76 -st topic167_1_0 -pt topic167_1_1 -u 0.0468522118761871 > ./result_10chains/node167_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_1 -p 303 -st topic167_2_0 -pt topic167_2_1 -u 0.004338897845854728 > ./result_10chains/node167_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_1 -p 355 -st topic167_3_0 -pt topic167_3_1 -u 0.009296553706366062 > ./result_10chains/node167_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_1 -p 379 -st topic167_4_0 -pt topic167_4_1 -u 0.012461889547493 > ./result_10chains/node167_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_1 -p 619 -st topic167_5_0 -pt topic167_5_1 -u 0.0053769148028285085 > ./result_10chains/node167_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_1 -p 624 -st topic167_6_0 -pt topic167_6_1 -u 0.0350061787269154 > ./result_10chains/node167_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_1 -p 662 -st topic167_7_0 -pt topic167_7_1 -u 0.0017997449012803757 > ./result_10chains/node167_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_8_1 -p 718 -st topic167_8_0 -pt topic167_8_1 -u 0.03064340997488739 > ./result_10chains/node167_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_9_1 -p 810 -st topic167_9_0 -pt topic167_9_1 -u 0.03635334941972425 > ./result_10chains/node167_9_1.txt &
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
    "./result_10chains/node167_0_1.txt 90"
    "./result_10chains/node167_1_1.txt 89"
    "./result_10chains/node167_2_1.txt 88"
    "./result_10chains/node167_3_1.txt 87"
    "./result_10chains/node167_4_1.txt 86"
    "./result_10chains/node167_5_1.txt 85"
    "./result_10chains/node167_6_1.txt 84"
    "./result_10chains/node167_7_1.txt 83"
    "./result_10chains/node167_8_1.txt 82"
    "./result_10chains/node167_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
