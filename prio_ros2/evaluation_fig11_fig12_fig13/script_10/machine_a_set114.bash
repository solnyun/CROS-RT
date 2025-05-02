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
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_2 -p 48 -st topic114_0_1 -pt None -u 0.007746944129936151 > ./result_10chains/node114_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_2 -p 185 -st topic114_1_1 -pt None -u 0.007643114917158966 > ./result_10chains/node114_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_2 -p 288 -st topic114_2_1 -pt None -u 0.002814925551006986 > ./result_10chains/node114_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_2 -p 305 -st topic114_3_1 -pt None -u 0.004641263583885058 > ./result_10chains/node114_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_2 -p 393 -st topic114_4_1 -pt None -u 0.017295372301188328 > ./result_10chains/node114_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_2 -p 737 -st topic114_5_1 -pt None -u 0.01799325406208796 > ./result_10chains/node114_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_2 -p 799 -st topic114_6_1 -pt None -u 0.00893188278274093 > ./result_10chains/node114_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_2 -p 904 -st topic114_7_1 -pt None -u 0.02317473224211465 > ./result_10chains/node114_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_8_2 -p 941 -st topic114_8_1 -pt None -u 0.011122989199370728 > ./result_10chains/node114_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_9_2 -p 971 -st topic114_9_1 -pt None -u 0.02771905045291784 > ./result_10chains/node114_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_0 -p 48 -st none -pt topic114_0_0 -u 0.02606230290520084 > ./result_10chains/node114_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_0 -p 185 -st none -pt topic114_1_0 -u 0.008369540792006858 > ./result_10chains/node114_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_0 -p 288 -st none -pt topic114_2_0 -u 0.0022835322186112728 > ./result_10chains/node114_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_0 -p 305 -st none -pt topic114_3_0 -u 0.010426064932034074 > ./result_10chains/node114_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_0 -p 393 -st none -pt topic114_4_0 -u 0.0033712449649251353 > ./result_10chains/node114_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_0 -p 737 -st none -pt topic114_5_0 -u 0.006705238835791327 > ./result_10chains/node114_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_0 -p 799 -st none -pt topic114_6_0 -u 0.0021800011957824883 > ./result_10chains/node114_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_0 -p 904 -st none -pt topic114_7_0 -u 0.0812110461030506 > ./result_10chains/node114_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_8_0 -p 941 -st none -pt topic114_8_0 -u 0.03917877009696405 > ./result_10chains/node114_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node114_9_0 -p 971 -st none -pt topic114_9_0 -u 0.0001686276801895828 > ./result_10chains/node114_9_0.txt &
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
    "./result_10chains/node114_0_0.txt 90"
    "./result_10chains/node114_0_2.txt 90"
    "./result_10chains/node114_1_0.txt 89"
    "./result_10chains/node114_1_2.txt 89"
    "./result_10chains/node114_2_0.txt 88"
    "./result_10chains/node114_2_2.txt 88"
    "./result_10chains/node114_3_0.txt 87"
    "./result_10chains/node114_3_2.txt 87"
    "./result_10chains/node114_4_0.txt 86"
    "./result_10chains/node114_4_2.txt 86"
    "./result_10chains/node114_5_0.txt 85"
    "./result_10chains/node114_5_2.txt 85"
    "./result_10chains/node114_6_0.txt 84"
    "./result_10chains/node114_6_2.txt 84"
    "./result_10chains/node114_7_0.txt 83"
    "./result_10chains/node114_7_2.txt 83"
    "./result_10chains/node114_8_0.txt 82"
    "./result_10chains/node114_8_2.txt 82"
    "./result_10chains/node114_9_0.txt 81"
    "./result_10chains/node114_9_2.txt 81"
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
