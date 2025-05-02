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
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_1 -p 60 -st topic489_0_0 -pt topic489_0_1 -u 0.0020120971527051723 > ./result_10chains/node489_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_1 -p 172 -st topic489_1_0 -pt topic489_1_1 -u 0.009645176972836123 > ./result_10chains/node489_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_1 -p 180 -st topic489_2_0 -pt topic489_2_1 -u 0.001888040579642536 > ./result_10chains/node489_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_1 -p 364 -st topic489_3_0 -pt topic489_3_1 -u 0.029760086457273016 > ./result_10chains/node489_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_1 -p 386 -st topic489_4_0 -pt topic489_4_1 -u 0.007147611124097175 > ./result_10chains/node489_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_1 -p 607 -st topic489_5_0 -pt topic489_5_1 -u 0.016019022197990285 > ./result_10chains/node489_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_1 -p 633 -st topic489_6_0 -pt topic489_6_1 -u 0.028542729641558517 > ./result_10chains/node489_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_1 -p 695 -st topic489_7_0 -pt topic489_7_1 -u 0.011856501035383604 > ./result_10chains/node489_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_8_1 -p 706 -st topic489_8_0 -pt topic489_8_1 -u 0.005393278806089752 > ./result_10chains/node489_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_9_1 -p 965 -st topic489_9_0 -pt topic489_9_1 -u 0.03853978385482982 > ./result_10chains/node489_9_1.txt &
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
    "./result_10chains/node489_0_1.txt 90"
    "./result_10chains/node489_1_1.txt 89"
    "./result_10chains/node489_2_1.txt 88"
    "./result_10chains/node489_3_1.txt 87"
    "./result_10chains/node489_4_1.txt 86"
    "./result_10chains/node489_5_1.txt 85"
    "./result_10chains/node489_6_1.txt 84"
    "./result_10chains/node489_7_1.txt 83"
    "./result_10chains/node489_8_1.txt 82"
    "./result_10chains/node489_9_1.txt 81"
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
