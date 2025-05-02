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
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_2 -p 222 -st topic175_0_1 -pt None -u 0.056091152162100366 > ./result_10chains/node175_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_2 -p 249 -st topic175_1_1 -pt None -u 0.003821466297351195 > ./result_10chains/node175_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_2 -p 264 -st topic175_2_1 -pt None -u 0.011822834584960307 > ./result_10chains/node175_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_2 -p 270 -st topic175_3_1 -pt None -u 0.02765649170865153 > ./result_10chains/node175_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_2 -p 278 -st topic175_4_1 -pt None -u 0.008700520382623311 > ./result_10chains/node175_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_2 -p 372 -st topic175_5_1 -pt None -u 0.018067088862256497 > ./result_10chains/node175_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_2 -p 633 -st topic175_6_1 -pt None -u 0.03206580345709026 > ./result_10chains/node175_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_2 -p 840 -st topic175_7_1 -pt None -u 0.006492535781417369 > ./result_10chains/node175_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_8_2 -p 977 -st topic175_8_1 -pt None -u 0.013000093802761965 > ./result_10chains/node175_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_9_2 -p 981 -st topic175_9_1 -pt None -u 0.00020910865752680186 > ./result_10chains/node175_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_0 -p 222 -st none -pt topic175_0_0 -u 0.06793897352162515 > ./result_10chains/node175_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_0 -p 249 -st none -pt topic175_1_0 -u 0.0001445464938008012 > ./result_10chains/node175_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_0 -p 264 -st none -pt topic175_2_0 -u 0.017714947296540495 > ./result_10chains/node175_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_0 -p 270 -st none -pt topic175_3_0 -u 0.0024213714827656108 > ./result_10chains/node175_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_0 -p 278 -st none -pt topic175_4_0 -u 0.015272650016795175 > ./result_10chains/node175_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_0 -p 372 -st none -pt topic175_5_0 -u 0.0006265090387423955 > ./result_10chains/node175_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_0 -p 633 -st none -pt topic175_6_0 -u 0.005762556972189636 > ./result_10chains/node175_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_0 -p 840 -st none -pt topic175_7_0 -u 0.06374572519493447 > ./result_10chains/node175_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_8_0 -p 977 -st none -pt topic175_8_0 -u 0.021634912364329524 > ./result_10chains/node175_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_9_0 -p 981 -st none -pt topic175_9_0 -u 0.014429262643365963 > ./result_10chains/node175_9_0.txt &
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
    "./result_10chains/node175_0_0.txt 90"
    "./result_10chains/node175_0_2.txt 90"
    "./result_10chains/node175_1_0.txt 89"
    "./result_10chains/node175_1_2.txt 89"
    "./result_10chains/node175_2_0.txt 88"
    "./result_10chains/node175_2_2.txt 88"
    "./result_10chains/node175_3_0.txt 87"
    "./result_10chains/node175_3_2.txt 87"
    "./result_10chains/node175_4_0.txt 86"
    "./result_10chains/node175_4_2.txt 86"
    "./result_10chains/node175_5_0.txt 85"
    "./result_10chains/node175_5_2.txt 85"
    "./result_10chains/node175_6_0.txt 84"
    "./result_10chains/node175_6_2.txt 84"
    "./result_10chains/node175_7_0.txt 83"
    "./result_10chains/node175_7_2.txt 83"
    "./result_10chains/node175_8_0.txt 82"
    "./result_10chains/node175_8_2.txt 82"
    "./result_10chains/node175_9_0.txt 81"
    "./result_10chains/node175_9_2.txt 81"
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
