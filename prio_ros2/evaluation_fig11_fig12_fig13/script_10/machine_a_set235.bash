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
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_2 -p 35 -st topic235_0_1 -pt None -u 0.0012379861480957266 > ./result_10chains/node235_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_2 -p 164 -st topic235_1_1 -pt None -u 0.03390656744318743 > ./result_10chains/node235_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_2 -p 335 -st topic235_2_1 -pt None -u 0.022684767093318514 > ./result_10chains/node235_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_2 -p 667 -st topic235_3_1 -pt None -u 0.00797735002002875 > ./result_10chains/node235_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_2 -p 686 -st topic235_4_1 -pt None -u 0.03558421274608953 > ./result_10chains/node235_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_2 -p 687 -st topic235_5_1 -pt None -u 0.06222196284606449 > ./result_10chains/node235_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_6_2 -p 766 -st topic235_6_1 -pt None -u 0.012029526104686689 > ./result_10chains/node235_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_7_2 -p 830 -st topic235_7_1 -pt None -u 0.007230327696142375 > ./result_10chains/node235_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_8_2 -p 860 -st topic235_8_1 -pt None -u 0.009521223753985258 > ./result_10chains/node235_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_9_2 -p 929 -st topic235_9_1 -pt None -u 0.0166584515557158 > ./result_10chains/node235_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_0 -p 35 -st none -pt topic235_0_0 -u 0.01811563437101532 > ./result_10chains/node235_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_0 -p 164 -st none -pt topic235_1_0 -u 0.0009485569222104084 > ./result_10chains/node235_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_0 -p 335 -st none -pt topic235_2_0 -u 0.0011063822808050627 > ./result_10chains/node235_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_0 -p 667 -st none -pt topic235_3_0 -u 0.03678872516153742 > ./result_10chains/node235_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_0 -p 686 -st none -pt topic235_4_0 -u 0.014643271448781747 > ./result_10chains/node235_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_0 -p 687 -st none -pt topic235_5_0 -u 0.024977311577241645 > ./result_10chains/node235_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_6_0 -p 766 -st none -pt topic235_6_0 -u 0.028976400820698578 > ./result_10chains/node235_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_7_0 -p 830 -st none -pt topic235_7_0 -u 0.00402282971597992 > ./result_10chains/node235_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_8_0 -p 860 -st none -pt topic235_8_0 -u 0.021236110116538524 > ./result_10chains/node235_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_9_0 -p 929 -st none -pt topic235_9_0 -u 0.015252496670427294 > ./result_10chains/node235_9_0.txt &
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
    "./result_10chains/node235_0_0.txt 90"
    "./result_10chains/node235_0_2.txt 90"
    "./result_10chains/node235_1_0.txt 89"
    "./result_10chains/node235_1_2.txt 89"
    "./result_10chains/node235_2_0.txt 88"
    "./result_10chains/node235_2_2.txt 88"
    "./result_10chains/node235_3_0.txt 87"
    "./result_10chains/node235_3_2.txt 87"
    "./result_10chains/node235_4_0.txt 86"
    "./result_10chains/node235_4_2.txt 86"
    "./result_10chains/node235_5_0.txt 85"
    "./result_10chains/node235_5_2.txt 85"
    "./result_10chains/node235_6_0.txt 84"
    "./result_10chains/node235_6_2.txt 84"
    "./result_10chains/node235_7_0.txt 83"
    "./result_10chains/node235_7_2.txt 83"
    "./result_10chains/node235_8_0.txt 82"
    "./result_10chains/node235_8_2.txt 82"
    "./result_10chains/node235_9_0.txt 81"
    "./result_10chains/node235_9_2.txt 81"
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
