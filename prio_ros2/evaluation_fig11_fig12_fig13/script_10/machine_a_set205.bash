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
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_2 -p 146 -st topic205_0_1 -pt None -u 0.010085800854103932 > ./result_10chains/node205_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_2 -p 259 -st topic205_1_1 -pt None -u 0.00774649179982656 > ./result_10chains/node205_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_2 -p 307 -st topic205_2_1 -pt None -u 0.02476081307137351 > ./result_10chains/node205_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_2 -p 337 -st topic205_3_1 -pt None -u 0.007340916170488543 > ./result_10chains/node205_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_2 -p 463 -st topic205_4_1 -pt None -u 0.02143019179908337 > ./result_10chains/node205_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_2 -p 620 -st topic205_5_1 -pt None -u 0.02658734543787128 > ./result_10chains/node205_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_2 -p 711 -st topic205_6_1 -pt None -u 0.03913212798158705 > ./result_10chains/node205_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_2 -p 715 -st topic205_7_1 -pt None -u 0.006435006590422357 > ./result_10chains/node205_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_8_2 -p 793 -st topic205_8_1 -pt None -u 0.00025186658711925936 > ./result_10chains/node205_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_9_2 -p 837 -st topic205_9_1 -pt None -u 0.031624838884451445 > ./result_10chains/node205_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_0 -p 146 -st none -pt topic205_0_0 -u 0.06815584520150886 > ./result_10chains/node205_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_0 -p 259 -st none -pt topic205_1_0 -u 0.019956649476607136 > ./result_10chains/node205_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_0 -p 307 -st none -pt topic205_2_0 -u 0.01132846821868011 > ./result_10chains/node205_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_0 -p 337 -st none -pt topic205_3_0 -u 0.005272943844367106 > ./result_10chains/node205_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_0 -p 463 -st none -pt topic205_4_0 -u 0.0013104719405649945 > ./result_10chains/node205_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_0 -p 620 -st none -pt topic205_5_0 -u 0.015398639571741368 > ./result_10chains/node205_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_0 -p 711 -st none -pt topic205_6_0 -u 0.007730980545794186 > ./result_10chains/node205_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_0 -p 715 -st none -pt topic205_7_0 -u 0.004397816399965754 > ./result_10chains/node205_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_8_0 -p 793 -st none -pt topic205_8_0 -u 0.002060893805864328 > ./result_10chains/node205_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_9_0 -p 837 -st none -pt topic205_9_0 -u 0.049235040767978945 > ./result_10chains/node205_9_0.txt &
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
    "./result_10chains/node205_0_0.txt 90"
    "./result_10chains/node205_0_2.txt 90"
    "./result_10chains/node205_1_0.txt 89"
    "./result_10chains/node205_1_2.txt 89"
    "./result_10chains/node205_2_0.txt 88"
    "./result_10chains/node205_2_2.txt 88"
    "./result_10chains/node205_3_0.txt 87"
    "./result_10chains/node205_3_2.txt 87"
    "./result_10chains/node205_4_0.txt 86"
    "./result_10chains/node205_4_2.txt 86"
    "./result_10chains/node205_5_0.txt 85"
    "./result_10chains/node205_5_2.txt 85"
    "./result_10chains/node205_6_0.txt 84"
    "./result_10chains/node205_6_2.txt 84"
    "./result_10chains/node205_7_0.txt 83"
    "./result_10chains/node205_7_2.txt 83"
    "./result_10chains/node205_8_0.txt 82"
    "./result_10chains/node205_8_2.txt 82"
    "./result_10chains/node205_9_0.txt 81"
    "./result_10chains/node205_9_2.txt 81"
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
