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
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_2 -p 47 -st topic78_0_1 -pt None -u 0.0018162077710854319 > ./result_10chains/node78_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_2 -p 58 -st topic78_1_1 -pt None -u 0.01493369090886243 > ./result_10chains/node78_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_2 -p 429 -st topic78_2_1 -pt None -u 0.013351004878304429 > ./result_10chains/node78_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_2 -p 454 -st topic78_3_1 -pt None -u 0.022248408025120237 > ./result_10chains/node78_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_2 -p 552 -st topic78_4_1 -pt None -u 0.01061552917515618 > ./result_10chains/node78_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_2 -p 582 -st topic78_5_1 -pt None -u 0.000748947512942244 > ./result_10chains/node78_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_6_2 -p 814 -st topic78_6_1 -pt None -u 0.035244399014386474 > ./result_10chains/node78_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_7_2 -p 873 -st topic78_7_1 -pt None -u 0.036045394103668055 > ./result_10chains/node78_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_8_2 -p 880 -st topic78_8_1 -pt None -u 0.00016765383988422838 > ./result_10chains/node78_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_9_2 -p 953 -st topic78_9_1 -pt None -u 0.026579616878870095 > ./result_10chains/node78_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_0 -p 47 -st none -pt topic78_0_0 -u 0.01771192124327492 > ./result_10chains/node78_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_0 -p 58 -st none -pt topic78_1_0 -u 0.016676235876778744 > ./result_10chains/node78_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_0 -p 429 -st none -pt topic78_2_0 -u 0.023637910101687143 > ./result_10chains/node78_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_0 -p 454 -st none -pt topic78_3_0 -u 0.0055852144209271315 > ./result_10chains/node78_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_0 -p 552 -st none -pt topic78_4_0 -u 0.004866204109791938 > ./result_10chains/node78_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_0 -p 582 -st none -pt topic78_5_0 -u 0.05693947366036653 > ./result_10chains/node78_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_6_0 -p 814 -st none -pt topic78_6_0 -u 0.06017483612150501 > ./result_10chains/node78_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_7_0 -p 873 -st none -pt topic78_7_0 -u 0.005333286968225215 > ./result_10chains/node78_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_8_0 -p 880 -st none -pt topic78_8_0 -u 0.008847066010432766 > ./result_10chains/node78_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_9_0 -p 953 -st none -pt topic78_9_0 -u 0.01695825077182895 > ./result_10chains/node78_9_0.txt &
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
    "./result_10chains/node78_0_0.txt 90"
    "./result_10chains/node78_0_2.txt 90"
    "./result_10chains/node78_1_0.txt 89"
    "./result_10chains/node78_1_2.txt 89"
    "./result_10chains/node78_2_0.txt 88"
    "./result_10chains/node78_2_2.txt 88"
    "./result_10chains/node78_3_0.txt 87"
    "./result_10chains/node78_3_2.txt 87"
    "./result_10chains/node78_4_0.txt 86"
    "./result_10chains/node78_4_2.txt 86"
    "./result_10chains/node78_5_0.txt 85"
    "./result_10chains/node78_5_2.txt 85"
    "./result_10chains/node78_6_0.txt 84"
    "./result_10chains/node78_6_2.txt 84"
    "./result_10chains/node78_7_0.txt 83"
    "./result_10chains/node78_7_2.txt 83"
    "./result_10chains/node78_8_0.txt 82"
    "./result_10chains/node78_8_2.txt 82"
    "./result_10chains/node78_9_0.txt 81"
    "./result_10chains/node78_9_2.txt 81"
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
