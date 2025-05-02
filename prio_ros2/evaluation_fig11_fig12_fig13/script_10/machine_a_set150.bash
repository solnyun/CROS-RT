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
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_2 -p 69 -st topic150_0_1 -pt None -u 0.006984550157428382 > ./result_10chains/node150_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_2 -p 170 -st topic150_1_1 -pt None -u 0.06584730103523828 > ./result_10chains/node150_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_2 -p 234 -st topic150_2_1 -pt None -u 0.018277617498696608 > ./result_10chains/node150_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_2 -p 283 -st topic150_3_1 -pt None -u 0.005359601972425021 > ./result_10chains/node150_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_2 -p 321 -st topic150_4_1 -pt None -u 0.026671255204855582 > ./result_10chains/node150_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_2 -p 369 -st topic150_5_1 -pt None -u 0.010763841810211894 > ./result_10chains/node150_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_6_2 -p 657 -st topic150_6_1 -pt None -u 0.02202227888615943 > ./result_10chains/node150_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_7_2 -p 784 -st topic150_7_1 -pt None -u 0.0024782143402445334 > ./result_10chains/node150_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_8_2 -p 879 -st topic150_8_1 -pt None -u 0.04034028691638856 > ./result_10chains/node150_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_9_2 -p 964 -st topic150_9_1 -pt None -u 0.04268421360476303 > ./result_10chains/node150_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_0 -p 69 -st none -pt topic150_0_0 -u 0.023432635852163874 > ./result_10chains/node150_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_0 -p 170 -st none -pt topic150_1_0 -u 0.0019533596314496027 > ./result_10chains/node150_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_0 -p 234 -st none -pt topic150_2_0 -u 0.015172052028626926 > ./result_10chains/node150_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_0 -p 283 -st none -pt topic150_3_0 -u 0.014915839282462595 > ./result_10chains/node150_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_0 -p 321 -st none -pt topic150_4_0 -u 0.005389805264654046 > ./result_10chains/node150_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_0 -p 369 -st none -pt topic150_5_0 -u 0.003282807125405296 > ./result_10chains/node150_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_6_0 -p 657 -st none -pt topic150_6_0 -u 0.013694835905658093 > ./result_10chains/node150_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_7_0 -p 784 -st none -pt topic150_7_0 -u 0.0024536153154728346 > ./result_10chains/node150_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_8_0 -p 879 -st none -pt topic150_8_0 -u 0.0018511275363582713 > ./result_10chains/node150_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_9_0 -p 964 -st none -pt topic150_9_0 -u 0.016490130331140863 > ./result_10chains/node150_9_0.txt &
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
    "./result_10chains/node150_0_0.txt 90"
    "./result_10chains/node150_0_2.txt 90"
    "./result_10chains/node150_1_0.txt 89"
    "./result_10chains/node150_1_2.txt 89"
    "./result_10chains/node150_2_0.txt 88"
    "./result_10chains/node150_2_2.txt 88"
    "./result_10chains/node150_3_0.txt 87"
    "./result_10chains/node150_3_2.txt 87"
    "./result_10chains/node150_4_0.txt 86"
    "./result_10chains/node150_4_2.txt 86"
    "./result_10chains/node150_5_0.txt 85"
    "./result_10chains/node150_5_2.txt 85"
    "./result_10chains/node150_6_0.txt 84"
    "./result_10chains/node150_6_2.txt 84"
    "./result_10chains/node150_7_0.txt 83"
    "./result_10chains/node150_7_2.txt 83"
    "./result_10chains/node150_8_0.txt 82"
    "./result_10chains/node150_8_2.txt 82"
    "./result_10chains/node150_9_0.txt 81"
    "./result_10chains/node150_9_2.txt 81"
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
