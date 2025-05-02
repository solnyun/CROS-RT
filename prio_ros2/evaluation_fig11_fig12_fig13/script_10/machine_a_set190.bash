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
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_2 -p 77 -st topic190_0_1 -pt None -u 0.03464369046951221 > ./result_10chains/node190_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_2 -p 264 -st topic190_1_1 -pt None -u 0.0016085870369678124 > ./result_10chains/node190_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_2 -p 305 -st topic190_2_1 -pt None -u 0.005460845790834168 > ./result_10chains/node190_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_2 -p 330 -st topic190_3_1 -pt None -u 0.01857195069049966 > ./result_10chains/node190_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_2 -p 476 -st topic190_4_1 -pt None -u 0.01442826566405958 > ./result_10chains/node190_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_2 -p 487 -st topic190_5_1 -pt None -u 0.016006927304040325 > ./result_10chains/node190_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_2 -p 490 -st topic190_6_1 -pt None -u 0.02424563323762005 > ./result_10chains/node190_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_2 -p 576 -st topic190_7_1 -pt None -u 0.05564622178078861 > ./result_10chains/node190_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_8_2 -p 579 -st topic190_8_1 -pt None -u 0.08302232030636253 > ./result_10chains/node190_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_9_2 -p 859 -st topic190_9_1 -pt None -u 0.007158145690770548 > ./result_10chains/node190_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_0 -p 77 -st none -pt topic190_0_0 -u 0.011056746804002704 > ./result_10chains/node190_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_0 -p 264 -st none -pt topic190_1_0 -u 0.01323769641604905 > ./result_10chains/node190_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_0 -p 305 -st none -pt topic190_2_0 -u 0.030132975120620742 > ./result_10chains/node190_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_0 -p 330 -st none -pt topic190_3_0 -u 0.028143481133464876 > ./result_10chains/node190_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_0 -p 476 -st none -pt topic190_4_0 -u 0.017235556030404997 > ./result_10chains/node190_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_0 -p 487 -st none -pt topic190_5_0 -u 0.02368190303728096 > ./result_10chains/node190_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_0 -p 490 -st none -pt topic190_6_0 -u 0.014050985998413063 > ./result_10chains/node190_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_0 -p 576 -st none -pt topic190_7_0 -u 0.008244546269134984 > ./result_10chains/node190_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_8_0 -p 579 -st none -pt topic190_8_0 -u 0.0014590610344492466 > ./result_10chains/node190_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_9_0 -p 859 -st none -pt topic190_9_0 -u 0.01719926605419106 > ./result_10chains/node190_9_0.txt &
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
    "./result_10chains/node190_0_0.txt 90"
    "./result_10chains/node190_0_2.txt 90"
    "./result_10chains/node190_1_0.txt 89"
    "./result_10chains/node190_1_2.txt 89"
    "./result_10chains/node190_2_0.txt 88"
    "./result_10chains/node190_2_2.txt 88"
    "./result_10chains/node190_3_0.txt 87"
    "./result_10chains/node190_3_2.txt 87"
    "./result_10chains/node190_4_0.txt 86"
    "./result_10chains/node190_4_2.txt 86"
    "./result_10chains/node190_5_0.txt 85"
    "./result_10chains/node190_5_2.txt 85"
    "./result_10chains/node190_6_0.txt 84"
    "./result_10chains/node190_6_2.txt 84"
    "./result_10chains/node190_7_0.txt 83"
    "./result_10chains/node190_7_2.txt 83"
    "./result_10chains/node190_8_0.txt 82"
    "./result_10chains/node190_8_2.txt 82"
    "./result_10chains/node190_9_0.txt 81"
    "./result_10chains/node190_9_2.txt 81"
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
