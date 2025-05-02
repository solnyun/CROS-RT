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
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_2 -p 94 -st topic319_0_1 -pt None -u 0.03734540089049848 > ./result_10chains/node319_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_2 -p 141 -st topic319_1_1 -pt None -u 0.02006832505990125 > ./result_10chains/node319_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_2 -p 146 -st topic319_2_1 -pt None -u 0.004887447990968241 > ./result_10chains/node319_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_2 -p 255 -st topic319_3_1 -pt None -u 0.020311081730259972 > ./result_10chains/node319_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_2 -p 319 -st topic319_4_1 -pt None -u 0.004972629736109735 > ./result_10chains/node319_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_2 -p 324 -st topic319_5_1 -pt None -u 0.06582042741155297 > ./result_10chains/node319_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_6_2 -p 373 -st topic319_6_1 -pt None -u 0.007494258502024981 > ./result_10chains/node319_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_7_2 -p 879 -st topic319_7_1 -pt None -u 0.00961134767974943 > ./result_10chains/node319_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_8_2 -p 889 -st topic319_8_1 -pt None -u 0.01144453456268324 > ./result_10chains/node319_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_9_2 -p 945 -st topic319_9_1 -pt None -u 0.007184020679559764 > ./result_10chains/node319_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_0 -p 94 -st none -pt topic319_0_0 -u 0.012490659255751602 > ./result_10chains/node319_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_0 -p 141 -st none -pt topic319_1_0 -u 0.005998396662623806 > ./result_10chains/node319_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_0 -p 146 -st none -pt topic319_2_0 -u 0.005296312833680039 > ./result_10chains/node319_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_0 -p 255 -st none -pt topic319_3_0 -u 0.03059326880369634 > ./result_10chains/node319_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_0 -p 319 -st none -pt topic319_4_0 -u 0.02361278747729456 > ./result_10chains/node319_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_0 -p 324 -st none -pt topic319_5_0 -u 0.017266178703521207 > ./result_10chains/node319_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_6_0 -p 373 -st none -pt topic319_6_0 -u 0.0098633869034577 > ./result_10chains/node319_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_7_0 -p 879 -st none -pt topic319_7_0 -u 0.00024708312719509684 > ./result_10chains/node319_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_8_0 -p 889 -st none -pt topic319_8_0 -u 0.0023701681920745427 > ./result_10chains/node319_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_9_0 -p 945 -st none -pt topic319_9_0 -u 0.039117771612535726 > ./result_10chains/node319_9_0.txt &
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
    "./result_10chains/node319_0_0.txt 90"
    "./result_10chains/node319_0_2.txt 90"
    "./result_10chains/node319_1_0.txt 89"
    "./result_10chains/node319_1_2.txt 89"
    "./result_10chains/node319_2_0.txt 88"
    "./result_10chains/node319_2_2.txt 88"
    "./result_10chains/node319_3_0.txt 87"
    "./result_10chains/node319_3_2.txt 87"
    "./result_10chains/node319_4_0.txt 86"
    "./result_10chains/node319_4_2.txt 86"
    "./result_10chains/node319_5_0.txt 85"
    "./result_10chains/node319_5_2.txt 85"
    "./result_10chains/node319_6_0.txt 84"
    "./result_10chains/node319_6_2.txt 84"
    "./result_10chains/node319_7_0.txt 83"
    "./result_10chains/node319_7_2.txt 83"
    "./result_10chains/node319_8_0.txt 82"
    "./result_10chains/node319_8_2.txt 82"
    "./result_10chains/node319_9_0.txt 81"
    "./result_10chains/node319_9_2.txt 81"
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
