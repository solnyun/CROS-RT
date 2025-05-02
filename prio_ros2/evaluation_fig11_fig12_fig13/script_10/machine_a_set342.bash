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
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_2 -p 27 -st topic342_0_1 -pt None -u 0.00451344898051409 > ./result_10chains/node342_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_2 -p 106 -st topic342_1_1 -pt None -u 0.04014383249635284 > ./result_10chains/node342_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_2 -p 341 -st topic342_2_1 -pt None -u 0.06554297922379726 > ./result_10chains/node342_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_2 -p 431 -st topic342_3_1 -pt None -u 0.01608296942979376 > ./result_10chains/node342_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_2 -p 589 -st topic342_4_1 -pt None -u 0.08524686193244838 > ./result_10chains/node342_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_2 -p 682 -st topic342_5_1 -pt None -u 0.0031541871679291733 > ./result_10chains/node342_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_2 -p 841 -st topic342_6_1 -pt None -u 0.011030482567628314 > ./result_10chains/node342_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_2 -p 867 -st topic342_7_1 -pt None -u 0.022560740624995954 > ./result_10chains/node342_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_8_2 -p 960 -st topic342_8_1 -pt None -u 0.021405671144188915 > ./result_10chains/node342_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_9_2 -p 981 -st topic342_9_1 -pt None -u 0.0042726421001993324 > ./result_10chains/node342_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_0 -p 27 -st none -pt topic342_0_0 -u 0.0008438919980164328 > ./result_10chains/node342_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_0 -p 106 -st none -pt topic342_1_0 -u 0.0016688261953057282 > ./result_10chains/node342_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_0 -p 341 -st none -pt topic342_2_0 -u 0.010795488865377234 > ./result_10chains/node342_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_0 -p 431 -st none -pt topic342_3_0 -u 0.01120521604637853 > ./result_10chains/node342_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_0 -p 589 -st none -pt topic342_4_0 -u 0.014563782498117073 > ./result_10chains/node342_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_0 -p 682 -st none -pt topic342_5_0 -u 0.005116890017593384 > ./result_10chains/node342_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_0 -p 841 -st none -pt topic342_6_0 -u 0.002364940708237201 > ./result_10chains/node342_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_0 -p 867 -st none -pt topic342_7_0 -u 0.02195686826360936 > ./result_10chains/node342_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_8_0 -p 960 -st none -pt topic342_8_0 -u 0.010853949979254401 > ./result_10chains/node342_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_9_0 -p 981 -st none -pt topic342_9_0 -u 0.005072184877589791 > ./result_10chains/node342_9_0.txt &
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
    "./result_10chains/node342_0_0.txt 90"
    "./result_10chains/node342_0_2.txt 90"
    "./result_10chains/node342_1_0.txt 89"
    "./result_10chains/node342_1_2.txt 89"
    "./result_10chains/node342_2_0.txt 88"
    "./result_10chains/node342_2_2.txt 88"
    "./result_10chains/node342_3_0.txt 87"
    "./result_10chains/node342_3_2.txt 87"
    "./result_10chains/node342_4_0.txt 86"
    "./result_10chains/node342_4_2.txt 86"
    "./result_10chains/node342_5_0.txt 85"
    "./result_10chains/node342_5_2.txt 85"
    "./result_10chains/node342_6_0.txt 84"
    "./result_10chains/node342_6_2.txt 84"
    "./result_10chains/node342_7_0.txt 83"
    "./result_10chains/node342_7_2.txt 83"
    "./result_10chains/node342_8_0.txt 82"
    "./result_10chains/node342_8_2.txt 82"
    "./result_10chains/node342_9_0.txt 81"
    "./result_10chains/node342_9_2.txt 81"
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
