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
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_2 -p 45 -st topic297_0_1 -pt None -u 0.04584292727359396 > ./result_10chains/node297_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_2 -p 72 -st topic297_1_1 -pt None -u 0.0020088230992198475 > ./result_10chains/node297_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_2 -p 426 -st topic297_2_1 -pt None -u 0.013281465648692592 > ./result_10chains/node297_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_2 -p 488 -st topic297_3_1 -pt None -u 0.009206188773335955 > ./result_10chains/node297_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_2 -p 517 -st topic297_4_1 -pt None -u 0.01119583123085427 > ./result_10chains/node297_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_2 -p 593 -st topic297_5_1 -pt None -u 0.005193965514007692 > ./result_10chains/node297_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_2 -p 812 -st topic297_6_1 -pt None -u 0.050684061957110865 > ./result_10chains/node297_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_2 -p 897 -st topic297_7_1 -pt None -u 0.0006105324233349613 > ./result_10chains/node297_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_8_2 -p 958 -st topic297_8_1 -pt None -u 0.008288904580476611 > ./result_10chains/node297_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_9_2 -p 974 -st topic297_9_1 -pt None -u 0.014886888260260607 > ./result_10chains/node297_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_0 -p 45 -st none -pt topic297_0_0 -u 0.023290146908065024 > ./result_10chains/node297_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_0 -p 72 -st none -pt topic297_1_0 -u 0.008760715245907935 > ./result_10chains/node297_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_0 -p 426 -st none -pt topic297_2_0 -u 0.005829415828272122 > ./result_10chains/node297_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_0 -p 488 -st none -pt topic297_3_0 -u 0.012274667558564989 > ./result_10chains/node297_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_0 -p 517 -st none -pt topic297_4_0 -u 0.04445186634676468 > ./result_10chains/node297_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_0 -p 593 -st none -pt topic297_5_0 -u 0.011168143115070611 > ./result_10chains/node297_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_0 -p 812 -st none -pt topic297_6_0 -u 0.018192400075235815 > ./result_10chains/node297_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_0 -p 897 -st none -pt topic297_7_0 -u 0.008887873747891892 > ./result_10chains/node297_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_8_0 -p 958 -st none -pt topic297_8_0 -u 0.01511148808255762 > ./result_10chains/node297_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_9_0 -p 974 -st none -pt topic297_9_0 -u 0.01793113569690763 > ./result_10chains/node297_9_0.txt &
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
    "./result_10chains/node297_0_0.txt 90"
    "./result_10chains/node297_0_2.txt 90"
    "./result_10chains/node297_1_0.txt 89"
    "./result_10chains/node297_1_2.txt 89"
    "./result_10chains/node297_2_0.txt 88"
    "./result_10chains/node297_2_2.txt 88"
    "./result_10chains/node297_3_0.txt 87"
    "./result_10chains/node297_3_2.txt 87"
    "./result_10chains/node297_4_0.txt 86"
    "./result_10chains/node297_4_2.txt 86"
    "./result_10chains/node297_5_0.txt 85"
    "./result_10chains/node297_5_2.txt 85"
    "./result_10chains/node297_6_0.txt 84"
    "./result_10chains/node297_6_2.txt 84"
    "./result_10chains/node297_7_0.txt 83"
    "./result_10chains/node297_7_2.txt 83"
    "./result_10chains/node297_8_0.txt 82"
    "./result_10chains/node297_8_2.txt 82"
    "./result_10chains/node297_9_0.txt 81"
    "./result_10chains/node297_9_2.txt 81"
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
