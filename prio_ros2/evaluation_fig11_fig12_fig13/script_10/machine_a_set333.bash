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
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_2 -p 10 -st topic333_0_1 -pt None -u 0.020651883787357384 > ./result_10chains/node333_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_2 -p 101 -st topic333_1_1 -pt None -u 0.0037417815658806752 > ./result_10chains/node333_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_2 -p 110 -st topic333_2_1 -pt None -u 0.0018212335111696953 > ./result_10chains/node333_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_2 -p 207 -st topic333_3_1 -pt None -u 0.006374748762879412 > ./result_10chains/node333_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_2 -p 368 -st topic333_4_1 -pt None -u 0.00339095886208568 > ./result_10chains/node333_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_2 -p 475 -st topic333_5_1 -pt None -u 0.03286690785881999 > ./result_10chains/node333_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_2 -p 780 -st topic333_6_1 -pt None -u 0.0039834214503352006 > ./result_10chains/node333_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_2 -p 860 -st topic333_7_1 -pt None -u 0.015497241743335569 > ./result_10chains/node333_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_8_2 -p 924 -st topic333_8_1 -pt None -u 0.012848054048830902 > ./result_10chains/node333_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_9_2 -p 965 -st topic333_9_1 -pt None -u 0.0029942037919786376 > ./result_10chains/node333_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_0 -p 10 -st none -pt topic333_0_0 -u 0.006004971586255292 > ./result_10chains/node333_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_0 -p 101 -st none -pt topic333_1_0 -u 0.015415706063155954 > ./result_10chains/node333_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_0 -p 110 -st none -pt topic333_2_0 -u 0.00399931309137308 > ./result_10chains/node333_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_0 -p 207 -st none -pt topic333_3_0 -u 0.03595371911672535 > ./result_10chains/node333_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_0 -p 368 -st none -pt topic333_4_0 -u 0.016556108491287302 > ./result_10chains/node333_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_0 -p 475 -st none -pt topic333_5_0 -u 0.026639463974320265 > ./result_10chains/node333_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_0 -p 780 -st none -pt topic333_6_0 -u 0.0008654506194323286 > ./result_10chains/node333_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_0 -p 860 -st none -pt topic333_7_0 -u 0.001301236037911796 > ./result_10chains/node333_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_8_0 -p 924 -st none -pt topic333_8_0 -u 0.020862182314324337 > ./result_10chains/node333_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node333_9_0 -p 965 -st none -pt topic333_9_0 -u 0.017954379611548096 > ./result_10chains/node333_9_0.txt &
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
    "./result_10chains/node333_0_0.txt 90"
    "./result_10chains/node333_0_2.txt 90"
    "./result_10chains/node333_1_0.txt 89"
    "./result_10chains/node333_1_2.txt 89"
    "./result_10chains/node333_2_0.txt 88"
    "./result_10chains/node333_2_2.txt 88"
    "./result_10chains/node333_3_0.txt 87"
    "./result_10chains/node333_3_2.txt 87"
    "./result_10chains/node333_4_0.txt 86"
    "./result_10chains/node333_4_2.txt 86"
    "./result_10chains/node333_5_0.txt 85"
    "./result_10chains/node333_5_2.txt 85"
    "./result_10chains/node333_6_0.txt 84"
    "./result_10chains/node333_6_2.txt 84"
    "./result_10chains/node333_7_0.txt 83"
    "./result_10chains/node333_7_2.txt 83"
    "./result_10chains/node333_8_0.txt 82"
    "./result_10chains/node333_8_2.txt 82"
    "./result_10chains/node333_9_0.txt 81"
    "./result_10chains/node333_9_2.txt 81"
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
