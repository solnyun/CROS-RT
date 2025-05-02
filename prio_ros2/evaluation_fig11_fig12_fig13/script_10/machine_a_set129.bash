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
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_2 -p 74 -st topic129_0_1 -pt None -u 0.03503015956566946 > ./result_10chains/node129_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_2 -p 110 -st topic129_1_1 -pt None -u 0.008882021190686817 > ./result_10chains/node129_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_2 -p 114 -st topic129_2_1 -pt None -u 0.0005192208501951789 > ./result_10chains/node129_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_2 -p 134 -st topic129_3_1 -pt None -u 0.00887244071762966 > ./result_10chains/node129_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_2 -p 178 -st topic129_4_1 -pt None -u 0.039031319373170115 > ./result_10chains/node129_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_2 -p 396 -st topic129_5_1 -pt None -u 0.03616647398832401 > ./result_10chains/node129_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_6_2 -p 555 -st topic129_6_1 -pt None -u 0.003389219123516196 > ./result_10chains/node129_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_7_2 -p 578 -st topic129_7_1 -pt None -u 0.014611441868652542 > ./result_10chains/node129_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_8_2 -p 621 -st topic129_8_1 -pt None -u 0.0024529973254603654 > ./result_10chains/node129_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_9_2 -p 950 -st topic129_9_1 -pt None -u 0.028372252523883087 > ./result_10chains/node129_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_0 -p 74 -st none -pt topic129_0_0 -u 0.048976534154189566 > ./result_10chains/node129_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_0 -p 110 -st none -pt topic129_1_0 -u 0.02761258404191108 > ./result_10chains/node129_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_0 -p 114 -st none -pt topic129_2_0 -u 0.01642911418386034 > ./result_10chains/node129_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_0 -p 134 -st none -pt topic129_3_0 -u 0.000422451678354141 > ./result_10chains/node129_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_0 -p 178 -st none -pt topic129_4_0 -u 0.0003849763597394418 > ./result_10chains/node129_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_0 -p 396 -st none -pt topic129_5_0 -u 0.00616843363379338 > ./result_10chains/node129_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_6_0 -p 555 -st none -pt topic129_6_0 -u 0.005355456833395583 > ./result_10chains/node129_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_7_0 -p 578 -st none -pt topic129_7_0 -u 0.02171236147919925 > ./result_10chains/node129_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_8_0 -p 621 -st none -pt topic129_8_0 -u 0.0012898953417860015 > ./result_10chains/node129_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_9_0 -p 950 -st none -pt topic129_9_0 -u 0.10084254855484259 > ./result_10chains/node129_9_0.txt &
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
    "./result_10chains/node129_0_0.txt 90"
    "./result_10chains/node129_0_2.txt 90"
    "./result_10chains/node129_1_0.txt 89"
    "./result_10chains/node129_1_2.txt 89"
    "./result_10chains/node129_2_0.txt 88"
    "./result_10chains/node129_2_2.txt 88"
    "./result_10chains/node129_3_0.txt 87"
    "./result_10chains/node129_3_2.txt 87"
    "./result_10chains/node129_4_0.txt 86"
    "./result_10chains/node129_4_2.txt 86"
    "./result_10chains/node129_5_0.txt 85"
    "./result_10chains/node129_5_2.txt 85"
    "./result_10chains/node129_6_0.txt 84"
    "./result_10chains/node129_6_2.txt 84"
    "./result_10chains/node129_7_0.txt 83"
    "./result_10chains/node129_7_2.txt 83"
    "./result_10chains/node129_8_0.txt 82"
    "./result_10chains/node129_8_2.txt 82"
    "./result_10chains/node129_9_0.txt 81"
    "./result_10chains/node129_9_2.txt 81"
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
