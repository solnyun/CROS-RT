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
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_2 -p 50 -st topic289_0_1 -pt None -u 0.012128001523021237 > ./result_10chains/node289_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_2 -p 92 -st topic289_1_1 -pt None -u 0.0031864581768453193 > ./result_10chains/node289_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_2 -p 260 -st topic289_2_1 -pt None -u 0.010803101912943591 > ./result_10chains/node289_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_2 -p 279 -st topic289_3_1 -pt None -u 0.0017313175577889361 > ./result_10chains/node289_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_2 -p 580 -st topic289_4_1 -pt None -u 0.0014177303569090083 > ./result_10chains/node289_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_2 -p 661 -st topic289_5_1 -pt None -u 0.001658312357923325 > ./result_10chains/node289_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_2 -p 717 -st topic289_6_1 -pt None -u 0.028049670013726963 > ./result_10chains/node289_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_2 -p 864 -st topic289_7_1 -pt None -u 0.024052837211037098 > ./result_10chains/node289_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_8_2 -p 924 -st topic289_8_1 -pt None -u 0.0006688766086794876 > ./result_10chains/node289_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_9_2 -p 973 -st topic289_9_1 -pt None -u 0.0018721163232851136 > ./result_10chains/node289_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_0 -p 50 -st none -pt topic289_0_0 -u 0.03885656745470656 > ./result_10chains/node289_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_0 -p 92 -st none -pt topic289_1_0 -u 0.002660855518714089 > ./result_10chains/node289_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_0 -p 260 -st none -pt topic289_2_0 -u 0.0034981081321052154 > ./result_10chains/node289_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_0 -p 279 -st none -pt topic289_3_0 -u 0.04293587326496534 > ./result_10chains/node289_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_0 -p 580 -st none -pt topic289_4_0 -u 0.06791496258897378 > ./result_10chains/node289_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_0 -p 661 -st none -pt topic289_5_0 -u 0.012429019065547942 > ./result_10chains/node289_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_0 -p 717 -st none -pt topic289_6_0 -u 0.009367965383262233 > ./result_10chains/node289_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_0 -p 864 -st none -pt topic289_7_0 -u 0.017866965400558973 > ./result_10chains/node289_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_8_0 -p 924 -st none -pt topic289_8_0 -u 0.010109162289746516 > ./result_10chains/node289_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node289_9_0 -p 973 -st none -pt topic289_9_0 -u 0.015736160224633693 > ./result_10chains/node289_9_0.txt &
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
    "./result_10chains/node289_0_0.txt 90"
    "./result_10chains/node289_0_2.txt 90"
    "./result_10chains/node289_1_0.txt 89"
    "./result_10chains/node289_1_2.txt 89"
    "./result_10chains/node289_2_0.txt 88"
    "./result_10chains/node289_2_2.txt 88"
    "./result_10chains/node289_3_0.txt 87"
    "./result_10chains/node289_3_2.txt 87"
    "./result_10chains/node289_4_0.txt 86"
    "./result_10chains/node289_4_2.txt 86"
    "./result_10chains/node289_5_0.txt 85"
    "./result_10chains/node289_5_2.txt 85"
    "./result_10chains/node289_6_0.txt 84"
    "./result_10chains/node289_6_2.txt 84"
    "./result_10chains/node289_7_0.txt 83"
    "./result_10chains/node289_7_2.txt 83"
    "./result_10chains/node289_8_0.txt 82"
    "./result_10chains/node289_8_2.txt 82"
    "./result_10chains/node289_9_0.txt 81"
    "./result_10chains/node289_9_2.txt 81"
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
