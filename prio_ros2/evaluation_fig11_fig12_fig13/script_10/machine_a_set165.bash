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
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_2 -p 17 -st topic165_0_1 -pt None -u 0.0203900140917449 > ./result_10chains/node165_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_2 -p 33 -st topic165_1_1 -pt None -u 0.0039737421681710905 > ./result_10chains/node165_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_2 -p 76 -st topic165_2_1 -pt None -u 0.017870510225742042 > ./result_10chains/node165_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_2 -p 415 -st topic165_3_1 -pt None -u 0.0008416007780628343 > ./result_10chains/node165_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_2 -p 494 -st topic165_4_1 -pt None -u 0.011370957980463392 > ./result_10chains/node165_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_2 -p 497 -st topic165_5_1 -pt None -u 0.043694661172182014 > ./result_10chains/node165_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_6_2 -p 545 -st topic165_6_1 -pt None -u 0.054400442256571785 > ./result_10chains/node165_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_7_2 -p 638 -st topic165_7_1 -pt None -u 0.000693537233815128 > ./result_10chains/node165_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_8_2 -p 665 -st topic165_8_1 -pt None -u 0.008015997615194937 > ./result_10chains/node165_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_9_2 -p 986 -st topic165_9_1 -pt None -u 0.005213051439330947 > ./result_10chains/node165_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_0 -p 17 -st none -pt topic165_0_0 -u 6.553894186372977e-05 > ./result_10chains/node165_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_0 -p 33 -st none -pt topic165_1_0 -u 0.0011031109481573487 > ./result_10chains/node165_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_0 -p 76 -st none -pt topic165_2_0 -u 0.0031658961499727023 > ./result_10chains/node165_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_0 -p 415 -st none -pt topic165_3_0 -u 0.010412188582018533 > ./result_10chains/node165_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_0 -p 494 -st none -pt topic165_4_0 -u 0.001950816810347089 > ./result_10chains/node165_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_0 -p 497 -st none -pt topic165_5_0 -u 0.003028186484454354 > ./result_10chains/node165_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_6_0 -p 545 -st none -pt topic165_6_0 -u 0.009332784768267072 > ./result_10chains/node165_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_7_0 -p 638 -st none -pt topic165_7_0 -u 0.02586119108630225 > ./result_10chains/node165_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_8_0 -p 665 -st none -pt topic165_8_0 -u 0.0059039669396739325 > ./result_10chains/node165_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_9_0 -p 986 -st none -pt topic165_9_0 -u 0.01588825540097857 > ./result_10chains/node165_9_0.txt &
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
    "./result_10chains/node165_0_0.txt 90"
    "./result_10chains/node165_0_2.txt 90"
    "./result_10chains/node165_1_0.txt 89"
    "./result_10chains/node165_1_2.txt 89"
    "./result_10chains/node165_2_0.txt 88"
    "./result_10chains/node165_2_2.txt 88"
    "./result_10chains/node165_3_0.txt 87"
    "./result_10chains/node165_3_2.txt 87"
    "./result_10chains/node165_4_0.txt 86"
    "./result_10chains/node165_4_2.txt 86"
    "./result_10chains/node165_5_0.txt 85"
    "./result_10chains/node165_5_2.txt 85"
    "./result_10chains/node165_6_0.txt 84"
    "./result_10chains/node165_6_2.txt 84"
    "./result_10chains/node165_7_0.txt 83"
    "./result_10chains/node165_7_2.txt 83"
    "./result_10chains/node165_8_0.txt 82"
    "./result_10chains/node165_8_2.txt 82"
    "./result_10chains/node165_9_0.txt 81"
    "./result_10chains/node165_9_2.txt 81"
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
