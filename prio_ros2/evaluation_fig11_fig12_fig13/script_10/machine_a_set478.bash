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
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_2 -p 68 -st topic478_0_1 -pt None -u 0.0037981942814003244 > ./result_10chains/node478_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_2 -p 84 -st topic478_1_1 -pt None -u 0.0003142581100224473 > ./result_10chains/node478_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_2 -p 139 -st topic478_2_1 -pt None -u 0.00480409713566754 > ./result_10chains/node478_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_2 -p 225 -st topic478_3_1 -pt None -u 0.05780519306243559 > ./result_10chains/node478_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_2 -p 269 -st topic478_4_1 -pt None -u 0.011185679637719825 > ./result_10chains/node478_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_2 -p 295 -st topic478_5_1 -pt None -u 0.017855416787194323 > ./result_10chains/node478_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_2 -p 436 -st topic478_6_1 -pt None -u 0.018728720460045867 > ./result_10chains/node478_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_2 -p 645 -st topic478_7_1 -pt None -u 0.09362949805156376 > ./result_10chains/node478_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_8_2 -p 711 -st topic478_8_1 -pt None -u 0.026975658569295104 > ./result_10chains/node478_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_9_2 -p 947 -st topic478_9_1 -pt None -u 0.00232241584995555 > ./result_10chains/node478_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_0 -p 68 -st none -pt topic478_0_0 -u 0.013549986882941567 > ./result_10chains/node478_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_0 -p 84 -st none -pt topic478_1_0 -u 0.00974262655176572 > ./result_10chains/node478_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_0 -p 139 -st none -pt topic478_2_0 -u 0.0025729239632321654 > ./result_10chains/node478_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_0 -p 225 -st none -pt topic478_3_0 -u 0.017458736503853378 > ./result_10chains/node478_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_0 -p 269 -st none -pt topic478_4_0 -u 0.004647458280846839 > ./result_10chains/node478_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_0 -p 295 -st none -pt topic478_5_0 -u 0.009911133353047663 > ./result_10chains/node478_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_0 -p 436 -st none -pt topic478_6_0 -u 0.0004315339566005605 > ./result_10chains/node478_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_0 -p 645 -st none -pt topic478_7_0 -u 0.01715335208240565 > ./result_10chains/node478_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_8_0 -p 711 -st none -pt topic478_8_0 -u 0.014969503607044535 > ./result_10chains/node478_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_9_0 -p 947 -st none -pt topic478_9_0 -u 0.024435505355830254 > ./result_10chains/node478_9_0.txt &
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
    "./result_10chains/node478_0_0.txt 90"
    "./result_10chains/node478_0_2.txt 90"
    "./result_10chains/node478_1_0.txt 89"
    "./result_10chains/node478_1_2.txt 89"
    "./result_10chains/node478_2_0.txt 88"
    "./result_10chains/node478_2_2.txt 88"
    "./result_10chains/node478_3_0.txt 87"
    "./result_10chains/node478_3_2.txt 87"
    "./result_10chains/node478_4_0.txt 86"
    "./result_10chains/node478_4_2.txt 86"
    "./result_10chains/node478_5_0.txt 85"
    "./result_10chains/node478_5_2.txt 85"
    "./result_10chains/node478_6_0.txt 84"
    "./result_10chains/node478_6_2.txt 84"
    "./result_10chains/node478_7_0.txt 83"
    "./result_10chains/node478_7_2.txt 83"
    "./result_10chains/node478_8_0.txt 82"
    "./result_10chains/node478_8_2.txt 82"
    "./result_10chains/node478_9_0.txt 81"
    "./result_10chains/node478_9_2.txt 81"
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
