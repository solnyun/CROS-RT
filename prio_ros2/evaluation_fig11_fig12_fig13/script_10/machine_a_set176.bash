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
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_2 -p 230 -st topic176_0_1 -pt None -u 0.0012564073398224629 > ./result_10chains/node176_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_2 -p 268 -st topic176_1_1 -pt None -u 0.01363193189340206 > ./result_10chains/node176_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_2 -p 420 -st topic176_2_1 -pt None -u 0.023711290677628005 > ./result_10chains/node176_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_2 -p 437 -st topic176_3_1 -pt None -u 0.0200145174310693 > ./result_10chains/node176_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_2 -p 609 -st topic176_4_1 -pt None -u 0.0028414636548076966 > ./result_10chains/node176_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_2 -p 647 -st topic176_5_1 -pt None -u 0.02276881328747976 > ./result_10chains/node176_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_2 -p 832 -st topic176_6_1 -pt None -u 0.004041890795868475 > ./result_10chains/node176_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_2 -p 842 -st topic176_7_1 -pt None -u 0.01178771262304381 > ./result_10chains/node176_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_8_2 -p 950 -st topic176_8_1 -pt None -u 0.01643279813159548 > ./result_10chains/node176_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_9_2 -p 967 -st topic176_9_1 -pt None -u 0.014599115155531629 > ./result_10chains/node176_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_0 -p 230 -st none -pt topic176_0_0 -u 0.012745203989986298 > ./result_10chains/node176_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_0 -p 268 -st none -pt topic176_1_0 -u 0.025614351587150974 > ./result_10chains/node176_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_0 -p 420 -st none -pt topic176_2_0 -u 0.011783959887757545 > ./result_10chains/node176_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_0 -p 437 -st none -pt topic176_3_0 -u 0.00044418717127725493 > ./result_10chains/node176_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_0 -p 609 -st none -pt topic176_4_0 -u 0.002060249017714455 > ./result_10chains/node176_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_0 -p 647 -st none -pt topic176_5_0 -u 0.05781785897441438 > ./result_10chains/node176_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_0 -p 832 -st none -pt topic176_6_0 -u 0.07129853838687242 > ./result_10chains/node176_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_0 -p 842 -st none -pt topic176_7_0 -u 0.01924474722723607 > ./result_10chains/node176_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_8_0 -p 950 -st none -pt topic176_8_0 -u 0.0003444071472034904 > ./result_10chains/node176_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_9_0 -p 967 -st none -pt topic176_9_0 -u 0.0010582478643267404 > ./result_10chains/node176_9_0.txt &
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
    "./result_10chains/node176_0_0.txt 90"
    "./result_10chains/node176_0_2.txt 90"
    "./result_10chains/node176_1_0.txt 89"
    "./result_10chains/node176_1_2.txt 89"
    "./result_10chains/node176_2_0.txt 88"
    "./result_10chains/node176_2_2.txt 88"
    "./result_10chains/node176_3_0.txt 87"
    "./result_10chains/node176_3_2.txt 87"
    "./result_10chains/node176_4_0.txt 86"
    "./result_10chains/node176_4_2.txt 86"
    "./result_10chains/node176_5_0.txt 85"
    "./result_10chains/node176_5_2.txt 85"
    "./result_10chains/node176_6_0.txt 84"
    "./result_10chains/node176_6_2.txt 84"
    "./result_10chains/node176_7_0.txt 83"
    "./result_10chains/node176_7_2.txt 83"
    "./result_10chains/node176_8_0.txt 82"
    "./result_10chains/node176_8_2.txt 82"
    "./result_10chains/node176_9_0.txt 81"
    "./result_10chains/node176_9_2.txt 81"
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
