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
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_2 -p 113 -st topic259_0_1 -pt None -u 0.03165949815215802 > ./result_8chains/node259_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_2 -p 163 -st topic259_1_1 -pt None -u 0.013914305564247276 > ./result_8chains/node259_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_2 -p 363 -st topic259_2_1 -pt None -u 0.009709031019626835 > ./result_8chains/node259_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_2 -p 502 -st topic259_3_1 -pt None -u 0.001889608171928292 > ./result_8chains/node259_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_2 -p 632 -st topic259_4_1 -pt None -u 0.050979235408703194 > ./result_8chains/node259_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_2 -p 890 -st topic259_5_1 -pt None -u 0.00042512400871647094 > ./result_8chains/node259_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_2 -p 926 -st topic259_6_1 -pt None -u 0.006624831706633555 > ./result_8chains/node259_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_2 -p 948 -st topic259_7_1 -pt None -u 0.04018047604180596 > ./result_8chains/node259_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_0 -p 113 -st none -pt topic259_0_0 -u 0.01717212771381138 > ./result_8chains/node259_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_0 -p 163 -st none -pt topic259_1_0 -u 0.045340200317483814 > ./result_8chains/node259_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_0 -p 363 -st none -pt topic259_2_0 -u 0.023718829226493654 > ./result_8chains/node259_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_0 -p 502 -st none -pt topic259_3_0 -u 0.0011006132844835204 > ./result_8chains/node259_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_0 -p 632 -st none -pt topic259_4_0 -u 0.0055097484968323895 > ./result_8chains/node259_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_0 -p 890 -st none -pt topic259_5_0 -u 0.021479591932465236 > ./result_8chains/node259_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_0 -p 926 -st none -pt topic259_6_0 -u 0.015255328536593366 > ./result_8chains/node259_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_0 -p 948 -st none -pt topic259_7_0 -u 0.07263962758719188 > ./result_8chains/node259_7_0.txt &
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
    "./result_8chains/node259_0_0.txt 90"
    "./result_8chains/node259_0_2.txt 90"
    "./result_8chains/node259_1_0.txt 89"
    "./result_8chains/node259_1_2.txt 89"
    "./result_8chains/node259_2_0.txt 88"
    "./result_8chains/node259_2_2.txt 88"
    "./result_8chains/node259_3_0.txt 87"
    "./result_8chains/node259_3_2.txt 87"
    "./result_8chains/node259_4_0.txt 86"
    "./result_8chains/node259_4_2.txt 86"
    "./result_8chains/node259_5_0.txt 85"
    "./result_8chains/node259_5_2.txt 85"
    "./result_8chains/node259_6_0.txt 84"
    "./result_8chains/node259_6_2.txt 84"
    "./result_8chains/node259_7_0.txt 83"
    "./result_8chains/node259_7_2.txt 83"
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
