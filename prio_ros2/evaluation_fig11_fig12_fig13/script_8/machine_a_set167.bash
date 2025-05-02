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
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_2 -p 101 -st topic167_0_1 -pt None -u 0.007682975933481939 > ./result_8chains/node167_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_2 -p 246 -st topic167_1_1 -pt None -u 0.04339460684466201 > ./result_8chains/node167_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_2 -p 360 -st topic167_2_1 -pt None -u 0.003518579375311248 > ./result_8chains/node167_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_2 -p 426 -st topic167_3_1 -pt None -u 0.03310564411268552 > ./result_8chains/node167_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_2 -p 771 -st topic167_4_1 -pt None -u 0.010679185897927213 > ./result_8chains/node167_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_2 -p 908 -st topic167_5_1 -pt None -u 0.05982442423193274 > ./result_8chains/node167_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_2 -p 911 -st topic167_6_1 -pt None -u 0.001956636171703996 > ./result_8chains/node167_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_2 -p 957 -st topic167_7_1 -pt None -u 0.033345079994815834 > ./result_8chains/node167_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_0 -p 101 -st none -pt topic167_0_0 -u 0.011687714114720416 > ./result_8chains/node167_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_0 -p 246 -st none -pt topic167_1_0 -u 0.04701883911044025 > ./result_8chains/node167_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_0 -p 360 -st none -pt topic167_2_0 -u 0.005145435267843224 > ./result_8chains/node167_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_0 -p 426 -st none -pt topic167_3_0 -u 0.013467932269133953 > ./result_8chains/node167_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_0 -p 771 -st none -pt topic167_4_0 -u 0.0057361614985278475 > ./result_8chains/node167_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_0 -p 908 -st none -pt topic167_5_0 -u 0.01227200183130911 > ./result_8chains/node167_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_0 -p 911 -st none -pt topic167_6_0 -u 0.00809831175826839 > ./result_8chains/node167_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_0 -p 957 -st none -pt topic167_7_0 -u 0.013943180303221087 > ./result_8chains/node167_7_0.txt &
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
    "./result_8chains/node167_0_0.txt 90"
    "./result_8chains/node167_0_2.txt 90"
    "./result_8chains/node167_1_0.txt 89"
    "./result_8chains/node167_1_2.txt 89"
    "./result_8chains/node167_2_0.txt 88"
    "./result_8chains/node167_2_2.txt 88"
    "./result_8chains/node167_3_0.txt 87"
    "./result_8chains/node167_3_2.txt 87"
    "./result_8chains/node167_4_0.txt 86"
    "./result_8chains/node167_4_2.txt 86"
    "./result_8chains/node167_5_0.txt 85"
    "./result_8chains/node167_5_2.txt 85"
    "./result_8chains/node167_6_0.txt 84"
    "./result_8chains/node167_6_2.txt 84"
    "./result_8chains/node167_7_0.txt 83"
    "./result_8chains/node167_7_2.txt 83"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
