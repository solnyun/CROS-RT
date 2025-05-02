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
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_2 -p 166 -st topic51_0_1 -pt None -u 0.044943567023684294 > ./result_10chains/node51_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_2 -p 178 -st topic51_1_1 -pt None -u 0.002053763861128932 > ./result_10chains/node51_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_2 -p 246 -st topic51_2_1 -pt None -u 0.0036677755705909476 > ./result_10chains/node51_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_2 -p 261 -st topic51_3_1 -pt None -u 0.012755119590860509 > ./result_10chains/node51_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_2 -p 453 -st topic51_4_1 -pt None -u 0.005941744775194602 > ./result_10chains/node51_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_2 -p 480 -st topic51_5_1 -pt None -u 0.001546218926020193 > ./result_10chains/node51_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_2 -p 488 -st topic51_6_1 -pt None -u 0.012778690013916127 > ./result_10chains/node51_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_2 -p 550 -st topic51_7_1 -pt None -u 0.009429505648383796 > ./result_10chains/node51_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_8_2 -p 735 -st topic51_8_1 -pt None -u 0.018403946775194004 > ./result_10chains/node51_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_9_2 -p 909 -st topic51_9_1 -pt None -u 0.036666535624645294 > ./result_10chains/node51_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_0 -p 166 -st none -pt topic51_0_0 -u 0.023746008429155918 > ./result_10chains/node51_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_0 -p 178 -st none -pt topic51_1_0 -u 0.006915170470021825 > ./result_10chains/node51_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_0 -p 246 -st none -pt topic51_2_0 -u 0.027424290779147875 > ./result_10chains/node51_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_0 -p 261 -st none -pt topic51_3_0 -u 0.0016199194994446775 > ./result_10chains/node51_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_0 -p 453 -st none -pt topic51_4_0 -u 0.03446741800520148 > ./result_10chains/node51_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_0 -p 480 -st none -pt topic51_5_0 -u 0.042803848122893895 > ./result_10chains/node51_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_0 -p 488 -st none -pt topic51_6_0 -u 0.015104525083847797 > ./result_10chains/node51_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_0 -p 550 -st none -pt topic51_7_0 -u 0.055518190948689705 > ./result_10chains/node51_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_8_0 -p 735 -st none -pt topic51_8_0 -u 0.007719529728487565 > ./result_10chains/node51_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_9_0 -p 909 -st none -pt topic51_9_0 -u 0.021900626986178298 > ./result_10chains/node51_9_0.txt &
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
    "./result_10chains/node51_0_0.txt 90"
    "./result_10chains/node51_0_2.txt 90"
    "./result_10chains/node51_1_0.txt 89"
    "./result_10chains/node51_1_2.txt 89"
    "./result_10chains/node51_2_0.txt 88"
    "./result_10chains/node51_2_2.txt 88"
    "./result_10chains/node51_3_0.txt 87"
    "./result_10chains/node51_3_2.txt 87"
    "./result_10chains/node51_4_0.txt 86"
    "./result_10chains/node51_4_2.txt 86"
    "./result_10chains/node51_5_0.txt 85"
    "./result_10chains/node51_5_2.txt 85"
    "./result_10chains/node51_6_0.txt 84"
    "./result_10chains/node51_6_2.txt 84"
    "./result_10chains/node51_7_0.txt 83"
    "./result_10chains/node51_7_2.txt 83"
    "./result_10chains/node51_8_0.txt 82"
    "./result_10chains/node51_8_2.txt 82"
    "./result_10chains/node51_9_0.txt 81"
    "./result_10chains/node51_9_2.txt 81"
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
