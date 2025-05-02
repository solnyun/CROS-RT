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
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_1 -p 36 -st topic109_0_0 -pt topic109_0_1 -u 0.0034013488387322766 > ./result_10chains/node109_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_1 -p 79 -st topic109_1_0 -pt topic109_1_1 -u 0.006691570223457455 > ./result_10chains/node109_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_1 -p 131 -st topic109_2_0 -pt topic109_2_1 -u 0.0012135120088739293 > ./result_10chains/node109_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_1 -p 240 -st topic109_3_0 -pt topic109_3_1 -u 0.021126820421793202 > ./result_10chains/node109_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_1 -p 397 -st topic109_4_0 -pt topic109_4_1 -u 0.005097853556797538 > ./result_10chains/node109_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_1 -p 410 -st topic109_5_0 -pt topic109_5_1 -u 0.012154269836420178 > ./result_10chains/node109_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_6_1 -p 411 -st topic109_6_0 -pt topic109_6_1 -u 0.040273178193936665 > ./result_10chains/node109_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_7_1 -p 547 -st topic109_7_0 -pt topic109_7_1 -u 0.03341558657036044 > ./result_10chains/node109_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_8_1 -p 884 -st topic109_8_0 -pt topic109_8_1 -u 0.0028864202650416837 > ./result_10chains/node109_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_9_1 -p 967 -st topic109_9_0 -pt topic109_9_1 -u 0.010032908409192375 > ./result_10chains/node109_9_1.txt &
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
    "./result_10chains/node109_0_1.txt 90"
    "./result_10chains/node109_1_1.txt 89"
    "./result_10chains/node109_2_1.txt 88"
    "./result_10chains/node109_3_1.txt 87"
    "./result_10chains/node109_4_1.txt 86"
    "./result_10chains/node109_5_1.txt 85"
    "./result_10chains/node109_6_1.txt 84"
    "./result_10chains/node109_7_1.txt 83"
    "./result_10chains/node109_8_1.txt 82"
    "./result_10chains/node109_9_1.txt 81"
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
