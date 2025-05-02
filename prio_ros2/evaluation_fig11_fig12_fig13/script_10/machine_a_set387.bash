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
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_2 -p 54 -st topic387_0_1 -pt None -u 0.010221707984158224 > ./result_10chains/node387_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_2 -p 96 -st topic387_1_1 -pt None -u 0.0003043194788686643 > ./result_10chains/node387_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_2 -p 159 -st topic387_2_1 -pt None -u 0.006091387391341685 > ./result_10chains/node387_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_2 -p 337 -st topic387_3_1 -pt None -u 0.007922530309722453 > ./result_10chains/node387_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_2 -p 469 -st topic387_4_1 -pt None -u 0.010693962720445815 > ./result_10chains/node387_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_2 -p 633 -st topic387_5_1 -pt None -u 0.002286953785980206 > ./result_10chains/node387_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_6_2 -p 676 -st topic387_6_1 -pt None -u 0.027972110435689146 > ./result_10chains/node387_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_7_2 -p 721 -st topic387_7_1 -pt None -u 0.003011362440334314 > ./result_10chains/node387_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_8_2 -p 873 -st topic387_8_1 -pt None -u 0.011494830770568697 > ./result_10chains/node387_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_9_2 -p 984 -st topic387_9_1 -pt None -u 0.0036196902054196544 > ./result_10chains/node387_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_0 -p 54 -st none -pt topic387_0_0 -u 0.010015089097015095 > ./result_10chains/node387_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_0 -p 96 -st none -pt topic387_1_0 -u 0.012478066418294076 > ./result_10chains/node387_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_0 -p 159 -st none -pt topic387_2_0 -u 0.008102920843516381 > ./result_10chains/node387_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_0 -p 337 -st none -pt topic387_3_0 -u 0.0036086527237039756 > ./result_10chains/node387_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_0 -p 469 -st none -pt topic387_4_0 -u 0.03991094429409214 > ./result_10chains/node387_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_0 -p 633 -st none -pt topic387_5_0 -u 0.002386188275933343 > ./result_10chains/node387_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_6_0 -p 676 -st none -pt topic387_6_0 -u 0.026730616014305708 > ./result_10chains/node387_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_7_0 -p 721 -st none -pt topic387_7_0 -u 0.004061598962647628 > ./result_10chains/node387_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_8_0 -p 873 -st none -pt topic387_8_0 -u 0.006989383366543353 > ./result_10chains/node387_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_9_0 -p 984 -st none -pt topic387_9_0 -u 0.026196978745747057 > ./result_10chains/node387_9_0.txt &
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
    "./result_10chains/node387_0_0.txt 90"
    "./result_10chains/node387_0_2.txt 90"
    "./result_10chains/node387_1_0.txt 89"
    "./result_10chains/node387_1_2.txt 89"
    "./result_10chains/node387_2_0.txt 88"
    "./result_10chains/node387_2_2.txt 88"
    "./result_10chains/node387_3_0.txt 87"
    "./result_10chains/node387_3_2.txt 87"
    "./result_10chains/node387_4_0.txt 86"
    "./result_10chains/node387_4_2.txt 86"
    "./result_10chains/node387_5_0.txt 85"
    "./result_10chains/node387_5_2.txt 85"
    "./result_10chains/node387_6_0.txt 84"
    "./result_10chains/node387_6_2.txt 84"
    "./result_10chains/node387_7_0.txt 83"
    "./result_10chains/node387_7_2.txt 83"
    "./result_10chains/node387_8_0.txt 82"
    "./result_10chains/node387_8_2.txt 82"
    "./result_10chains/node387_9_0.txt 81"
    "./result_10chains/node387_9_2.txt 81"
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
