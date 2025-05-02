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
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_2 -p 50 -st topic168_0_1 -pt None -u 0.0036934409718130112 > ./result_10chains/node168_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_2 -p 70 -st topic168_1_1 -pt None -u 0.012270585625233088 > ./result_10chains/node168_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_2 -p 128 -st topic168_2_1 -pt None -u 0.009910454059954943 > ./result_10chains/node168_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_2 -p 204 -st topic168_3_1 -pt None -u 0.017031003065693773 > ./result_10chains/node168_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_2 -p 360 -st topic168_4_1 -pt None -u 0.04562977571901422 > ./result_10chains/node168_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_2 -p 411 -st topic168_5_1 -pt None -u 0.007408526050705799 > ./result_10chains/node168_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_6_2 -p 465 -st topic168_6_1 -pt None -u 0.012748431861778486 > ./result_10chains/node168_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_7_2 -p 573 -st topic168_7_1 -pt None -u 0.011179949615651552 > ./result_10chains/node168_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_8_2 -p 692 -st topic168_8_1 -pt None -u 0.00109527156395485 > ./result_10chains/node168_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_9_2 -p 702 -st topic168_9_1 -pt None -u 0.004771575196094513 > ./result_10chains/node168_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_0 -p 50 -st none -pt topic168_0_0 -u 0.015020159548670253 > ./result_10chains/node168_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_0 -p 70 -st none -pt topic168_1_0 -u 0.02011856128844236 > ./result_10chains/node168_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_0 -p 128 -st none -pt topic168_2_0 -u 0.02770134361940013 > ./result_10chains/node168_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_0 -p 204 -st none -pt topic168_3_0 -u 0.003277582208054186 > ./result_10chains/node168_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_0 -p 360 -st none -pt topic168_4_0 -u 0.0412171942894089 > ./result_10chains/node168_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_0 -p 411 -st none -pt topic168_5_0 -u 0.02007141144098895 > ./result_10chains/node168_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_6_0 -p 465 -st none -pt topic168_6_0 -u 0.022286102044294598 > ./result_10chains/node168_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_7_0 -p 573 -st none -pt topic168_7_0 -u 0.0025311663928024586 > ./result_10chains/node168_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_8_0 -p 692 -st none -pt topic168_8_0 -u 0.017310044251853007 > ./result_10chains/node168_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_9_0 -p 702 -st none -pt topic168_9_0 -u 0.019414493590637363 > ./result_10chains/node168_9_0.txt &
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
    "./result_10chains/node168_0_0.txt 90"
    "./result_10chains/node168_0_2.txt 90"
    "./result_10chains/node168_1_0.txt 89"
    "./result_10chains/node168_1_2.txt 89"
    "./result_10chains/node168_2_0.txt 88"
    "./result_10chains/node168_2_2.txt 88"
    "./result_10chains/node168_3_0.txt 87"
    "./result_10chains/node168_3_2.txt 87"
    "./result_10chains/node168_4_0.txt 86"
    "./result_10chains/node168_4_2.txt 86"
    "./result_10chains/node168_5_0.txt 85"
    "./result_10chains/node168_5_2.txt 85"
    "./result_10chains/node168_6_0.txt 84"
    "./result_10chains/node168_6_2.txt 84"
    "./result_10chains/node168_7_0.txt 83"
    "./result_10chains/node168_7_2.txt 83"
    "./result_10chains/node168_8_0.txt 82"
    "./result_10chains/node168_8_2.txt 82"
    "./result_10chains/node168_9_0.txt 81"
    "./result_10chains/node168_9_2.txt 81"
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
