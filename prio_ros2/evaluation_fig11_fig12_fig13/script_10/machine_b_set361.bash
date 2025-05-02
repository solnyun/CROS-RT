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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_1 -p 184 -st topic361_0_0 -pt topic361_0_1 -u 0.030519048420178108 > ./result_10chains/node361_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_1 -p 352 -st topic361_1_0 -pt topic361_1_1 -u 0.02293935278332443 > ./result_10chains/node361_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_1 -p 412 -st topic361_2_0 -pt topic361_2_1 -u 0.0014157573659414613 > ./result_10chains/node361_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_1 -p 526 -st topic361_3_0 -pt topic361_3_1 -u 0.052658528513394726 > ./result_10chains/node361_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_1 -p 635 -st topic361_4_0 -pt topic361_4_1 -u 0.012991759591842539 > ./result_10chains/node361_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_1 -p 817 -st topic361_5_0 -pt topic361_5_1 -u 0.02168030757829781 > ./result_10chains/node361_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_1 -p 844 -st topic361_6_0 -pt topic361_6_1 -u 0.005409062328119538 > ./result_10chains/node361_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_1 -p 936 -st topic361_7_0 -pt topic361_7_1 -u 0.0081371407531622 > ./result_10chains/node361_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_8_1 -p 975 -st topic361_8_0 -pt topic361_8_1 -u 0.016300674006398473 > ./result_10chains/node361_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_9_1 -p 993 -st topic361_9_0 -pt topic361_9_1 -u 0.013531945329207751 > ./result_10chains/node361_9_1.txt &
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
    "./result_10chains/node361_0_1.txt 90"
    "./result_10chains/node361_1_1.txt 89"
    "./result_10chains/node361_2_1.txt 88"
    "./result_10chains/node361_3_1.txt 87"
    "./result_10chains/node361_4_1.txt 86"
    "./result_10chains/node361_5_1.txt 85"
    "./result_10chains/node361_6_1.txt 84"
    "./result_10chains/node361_7_1.txt 83"
    "./result_10chains/node361_8_1.txt 82"
    "./result_10chains/node361_9_1.txt 81"
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
