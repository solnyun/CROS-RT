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
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_2 -p 150 -st topic144_0_1 -pt None -u 0.023271177595056314 > ./result_10chains/node144_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_2 -p 156 -st topic144_1_1 -pt None -u 0.018826306222105793 > ./result_10chains/node144_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_2 -p 351 -st topic144_2_1 -pt None -u 0.004242303231143552 > ./result_10chains/node144_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_2 -p 387 -st topic144_3_1 -pt None -u 0.020449623117898386 > ./result_10chains/node144_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_2 -p 428 -st topic144_4_1 -pt None -u 0.0060588498851890105 > ./result_10chains/node144_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_2 -p 549 -st topic144_5_1 -pt None -u 0.03558432865187047 > ./result_10chains/node144_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_2 -p 562 -st topic144_6_1 -pt None -u 0.01410807786105095 > ./result_10chains/node144_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_2 -p 649 -st topic144_7_1 -pt None -u 0.006744255758378032 > ./result_10chains/node144_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_8_2 -p 906 -st topic144_8_1 -pt None -u 0.0085652932388611 > ./result_10chains/node144_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_9_2 -p 939 -st topic144_9_1 -pt None -u 0.013920695990670074 > ./result_10chains/node144_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_0 -p 150 -st none -pt topic144_0_0 -u 0.000970745873660861 > ./result_10chains/node144_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_0 -p 156 -st none -pt topic144_1_0 -u 0.00589438936905734 > ./result_10chains/node144_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_0 -p 351 -st none -pt topic144_2_0 -u 0.03830164231936711 > ./result_10chains/node144_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_0 -p 387 -st none -pt topic144_3_0 -u 0.0016353282270544223 > ./result_10chains/node144_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_0 -p 428 -st none -pt topic144_4_0 -u 0.0063342948797271426 > ./result_10chains/node144_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_0 -p 549 -st none -pt topic144_5_0 -u 0.005935556806272224 > ./result_10chains/node144_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_0 -p 562 -st none -pt topic144_6_0 -u 0.0021895953293351034 > ./result_10chains/node144_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_0 -p 649 -st none -pt topic144_7_0 -u 0.016640653636166416 > ./result_10chains/node144_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_8_0 -p 906 -st none -pt topic144_8_0 -u 0.003958482493954779 > ./result_10chains/node144_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_9_0 -p 939 -st none -pt topic144_9_0 -u 0.005358035858870472 > ./result_10chains/node144_9_0.txt &
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
    "./result_10chains/node144_0_0.txt 90"
    "./result_10chains/node144_0_2.txt 90"
    "./result_10chains/node144_1_0.txt 89"
    "./result_10chains/node144_1_2.txt 89"
    "./result_10chains/node144_2_0.txt 88"
    "./result_10chains/node144_2_2.txt 88"
    "./result_10chains/node144_3_0.txt 87"
    "./result_10chains/node144_3_2.txt 87"
    "./result_10chains/node144_4_0.txt 86"
    "./result_10chains/node144_4_2.txt 86"
    "./result_10chains/node144_5_0.txt 85"
    "./result_10chains/node144_5_2.txt 85"
    "./result_10chains/node144_6_0.txt 84"
    "./result_10chains/node144_6_2.txt 84"
    "./result_10chains/node144_7_0.txt 83"
    "./result_10chains/node144_7_2.txt 83"
    "./result_10chains/node144_8_0.txt 82"
    "./result_10chains/node144_8_2.txt 82"
    "./result_10chains/node144_9_0.txt 81"
    "./result_10chains/node144_9_2.txt 81"
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
