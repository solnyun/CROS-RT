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
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_2 -p 13 -st topic219_0_1 -pt None -u 0.044623195104668556 > ./result_10chains/node219_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_2 -p 48 -st topic219_1_1 -pt None -u 0.03499026972264607 > ./result_10chains/node219_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_2 -p 81 -st topic219_2_1 -pt None -u 0.023698873147480648 > ./result_10chains/node219_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_2 -p 151 -st topic219_3_1 -pt None -u 0.036169891010538635 > ./result_10chains/node219_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_2 -p 249 -st topic219_4_1 -pt None -u 0.007148674028942065 > ./result_10chains/node219_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_2 -p 331 -st topic219_5_1 -pt None -u 0.01043806695906524 > ./result_10chains/node219_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_2 -p 530 -st topic219_6_1 -pt None -u 0.0006928696202506412 > ./result_10chains/node219_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_2 -p 612 -st topic219_7_1 -pt None -u 0.00497605262808265 > ./result_10chains/node219_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_8_2 -p 727 -st topic219_8_1 -pt None -u 0.009569130260407295 > ./result_10chains/node219_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_9_2 -p 794 -st topic219_9_1 -pt None -u 0.014684369568024805 > ./result_10chains/node219_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_0 -p 13 -st none -pt topic219_0_0 -u 0.004770034174518156 > ./result_10chains/node219_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_0 -p 48 -st none -pt topic219_1_0 -u 0.0006227021746229022 > ./result_10chains/node219_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_0 -p 81 -st none -pt topic219_2_0 -u 0.009657487143409083 > ./result_10chains/node219_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_0 -p 151 -st none -pt topic219_3_0 -u 0.009273832914422742 > ./result_10chains/node219_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_0 -p 249 -st none -pt topic219_4_0 -u 0.011508302250968078 > ./result_10chains/node219_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_0 -p 331 -st none -pt topic219_5_0 -u 0.009152932885458043 > ./result_10chains/node219_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_0 -p 530 -st none -pt topic219_6_0 -u 0.013161317551505819 > ./result_10chains/node219_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_0 -p 612 -st none -pt topic219_7_0 -u 0.003533481241195638 > ./result_10chains/node219_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_8_0 -p 727 -st none -pt topic219_8_0 -u 0.011868528577073698 > ./result_10chains/node219_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_9_0 -p 794 -st none -pt topic219_9_0 -u 0.000629344055800448 > ./result_10chains/node219_9_0.txt &
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
    "./result_10chains/node219_0_0.txt 90"
    "./result_10chains/node219_0_2.txt 90"
    "./result_10chains/node219_1_0.txt 89"
    "./result_10chains/node219_1_2.txt 89"
    "./result_10chains/node219_2_0.txt 88"
    "./result_10chains/node219_2_2.txt 88"
    "./result_10chains/node219_3_0.txt 87"
    "./result_10chains/node219_3_2.txt 87"
    "./result_10chains/node219_4_0.txt 86"
    "./result_10chains/node219_4_2.txt 86"
    "./result_10chains/node219_5_0.txt 85"
    "./result_10chains/node219_5_2.txt 85"
    "./result_10chains/node219_6_0.txt 84"
    "./result_10chains/node219_6_2.txt 84"
    "./result_10chains/node219_7_0.txt 83"
    "./result_10chains/node219_7_2.txt 83"
    "./result_10chains/node219_8_0.txt 82"
    "./result_10chains/node219_8_2.txt 82"
    "./result_10chains/node219_9_0.txt 81"
    "./result_10chains/node219_9_2.txt 81"
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
