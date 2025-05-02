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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_2 -p 81 -st topic104_0_1 -pt None -u 0.0031650720904041196 > ./result_10chains/node104_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_2 -p 82 -st topic104_1_1 -pt None -u 0.0518262728840847 > ./result_10chains/node104_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_2 -p 109 -st topic104_2_1 -pt None -u 0.01714675033126717 > ./result_10chains/node104_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_2 -p 279 -st topic104_3_1 -pt None -u 0.0014860787718511959 > ./result_10chains/node104_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_2 -p 303 -st topic104_4_1 -pt None -u 0.04178698829979824 > ./result_10chains/node104_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_2 -p 314 -st topic104_5_1 -pt None -u 0.0016223522824272696 > ./result_10chains/node104_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_2 -p 380 -st topic104_6_1 -pt None -u 0.00849304214766547 > ./result_10chains/node104_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_2 -p 669 -st topic104_7_1 -pt None -u 0.00040176064247755827 > ./result_10chains/node104_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_8_2 -p 707 -st topic104_8_1 -pt None -u 0.01946764980254228 > ./result_10chains/node104_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_9_2 -p 922 -st topic104_9_1 -pt None -u 0.006041717092908363 > ./result_10chains/node104_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_0 -p 81 -st none -pt topic104_0_0 -u 0.016499426040513077 > ./result_10chains/node104_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_0 -p 82 -st none -pt topic104_1_0 -u 0.026866289447831815 > ./result_10chains/node104_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_0 -p 109 -st none -pt topic104_2_0 -u 0.0024711670298182553 > ./result_10chains/node104_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_0 -p 279 -st none -pt topic104_3_0 -u 0.008964062570193443 > ./result_10chains/node104_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_0 -p 303 -st none -pt topic104_4_0 -u 0.029074754275859482 > ./result_10chains/node104_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_0 -p 314 -st none -pt topic104_5_0 -u 0.01684434675616453 > ./result_10chains/node104_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_0 -p 380 -st none -pt topic104_6_0 -u 0.005569390717462763 > ./result_10chains/node104_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_0 -p 669 -st none -pt topic104_7_0 -u 0.003729295327887683 > ./result_10chains/node104_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_8_0 -p 707 -st none -pt topic104_8_0 -u 0.032546166770386485 > ./result_10chains/node104_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_9_0 -p 922 -st none -pt topic104_9_0 -u 0.0032472477215983314 > ./result_10chains/node104_9_0.txt &
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
    "./result_10chains/node104_0_0.txt 90"
    "./result_10chains/node104_0_2.txt 90"
    "./result_10chains/node104_1_0.txt 89"
    "./result_10chains/node104_1_2.txt 89"
    "./result_10chains/node104_2_0.txt 88"
    "./result_10chains/node104_2_2.txt 88"
    "./result_10chains/node104_3_0.txt 87"
    "./result_10chains/node104_3_2.txt 87"
    "./result_10chains/node104_4_0.txt 86"
    "./result_10chains/node104_4_2.txt 86"
    "./result_10chains/node104_5_0.txt 85"
    "./result_10chains/node104_5_2.txt 85"
    "./result_10chains/node104_6_0.txt 84"
    "./result_10chains/node104_6_2.txt 84"
    "./result_10chains/node104_7_0.txt 83"
    "./result_10chains/node104_7_2.txt 83"
    "./result_10chains/node104_8_0.txt 82"
    "./result_10chains/node104_8_2.txt 82"
    "./result_10chains/node104_9_0.txt 81"
    "./result_10chains/node104_9_2.txt 81"
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
