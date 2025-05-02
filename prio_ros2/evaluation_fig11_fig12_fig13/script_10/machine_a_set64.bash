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
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_2 -p 77 -st topic64_0_1 -pt None -u 0.0064298832359207525 > ./result_10chains/node64_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_2 -p 126 -st topic64_1_1 -pt None -u 0.005408814862235045 > ./result_10chains/node64_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_2 -p 142 -st topic64_2_1 -pt None -u 0.0006309370848021079 > ./result_10chains/node64_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_2 -p 164 -st topic64_3_1 -pt None -u 0.011111624399578357 > ./result_10chains/node64_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_2 -p 308 -st topic64_4_1 -pt None -u 0.04356492438801121 > ./result_10chains/node64_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_2 -p 527 -st topic64_5_1 -pt None -u 0.009857899723726832 > ./result_10chains/node64_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_6_2 -p 690 -st topic64_6_1 -pt None -u 0.02974284490172205 > ./result_10chains/node64_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_7_2 -p 706 -st topic64_7_1 -pt None -u 0.021491023442861593 > ./result_10chains/node64_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_8_2 -p 791 -st topic64_8_1 -pt None -u 0.006242932909560531 > ./result_10chains/node64_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_9_2 -p 855 -st topic64_9_1 -pt None -u 0.01776391894659843 > ./result_10chains/node64_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_0 -p 77 -st none -pt topic64_0_0 -u 0.01872509908271419 > ./result_10chains/node64_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_0 -p 126 -st none -pt topic64_1_0 -u 0.01710888787097342 > ./result_10chains/node64_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_0 -p 142 -st none -pt topic64_2_0 -u 0.0223496201768017 > ./result_10chains/node64_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_0 -p 164 -st none -pt topic64_3_0 -u 0.028639145232520424 > ./result_10chains/node64_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_0 -p 308 -st none -pt topic64_4_0 -u 0.01579851252378206 > ./result_10chains/node64_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_0 -p 527 -st none -pt topic64_5_0 -u 0.007938116574996934 > ./result_10chains/node64_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_6_0 -p 690 -st none -pt topic64_6_0 -u 0.005772421843974224 > ./result_10chains/node64_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_7_0 -p 706 -st none -pt topic64_7_0 -u 0.033505039622957394 > ./result_10chains/node64_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_8_0 -p 791 -st none -pt topic64_8_0 -u 0.0004183593014651654 > ./result_10chains/node64_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_9_0 -p 855 -st none -pt topic64_9_0 -u 0.0014855719010917895 > ./result_10chains/node64_9_0.txt &
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
    "./result_10chains/node64_0_0.txt 90"
    "./result_10chains/node64_0_2.txt 90"
    "./result_10chains/node64_1_0.txt 89"
    "./result_10chains/node64_1_2.txt 89"
    "./result_10chains/node64_2_0.txt 88"
    "./result_10chains/node64_2_2.txt 88"
    "./result_10chains/node64_3_0.txt 87"
    "./result_10chains/node64_3_2.txt 87"
    "./result_10chains/node64_4_0.txt 86"
    "./result_10chains/node64_4_2.txt 86"
    "./result_10chains/node64_5_0.txt 85"
    "./result_10chains/node64_5_2.txt 85"
    "./result_10chains/node64_6_0.txt 84"
    "./result_10chains/node64_6_2.txt 84"
    "./result_10chains/node64_7_0.txt 83"
    "./result_10chains/node64_7_2.txt 83"
    "./result_10chains/node64_8_0.txt 82"
    "./result_10chains/node64_8_2.txt 82"
    "./result_10chains/node64_9_0.txt 81"
    "./result_10chains/node64_9_2.txt 81"
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
