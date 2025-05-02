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
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_2 -p 35 -st topic12_0_1 -pt None -u 0.020207834752467624 > ./result_10chains/node12_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_2 -p 43 -st topic12_1_1 -pt None -u 0.015374703552322344 > ./result_10chains/node12_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_2 -p 190 -st topic12_2_1 -pt None -u 0.003707028854289085 > ./result_10chains/node12_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_2 -p 277 -st topic12_3_1 -pt None -u 0.03134075833103456 > ./result_10chains/node12_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_2 -p 444 -st topic12_4_1 -pt None -u 0.002118196564840913 > ./result_10chains/node12_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_2 -p 469 -st topic12_5_1 -pt None -u 0.02337975591717678 > ./result_10chains/node12_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_2 -p 483 -st topic12_6_1 -pt None -u 0.010897919892665031 > ./result_10chains/node12_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_2 -p 497 -st topic12_7_1 -pt None -u 0.060808659446888416 > ./result_10chains/node12_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_8_2 -p 604 -st topic12_8_1 -pt None -u 0.05947451323625705 > ./result_10chains/node12_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_9_2 -p 888 -st topic12_9_1 -pt None -u 0.005756036415051847 > ./result_10chains/node12_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_0 -p 35 -st none -pt topic12_0_0 -u 0.0362085334772439 > ./result_10chains/node12_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_0 -p 43 -st none -pt topic12_1_0 -u 0.011169210327933443 > ./result_10chains/node12_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_0 -p 190 -st none -pt topic12_2_0 -u 0.021633482338974386 > ./result_10chains/node12_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_0 -p 277 -st none -pt topic12_3_0 -u 0.0025395220738685387 > ./result_10chains/node12_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_0 -p 444 -st none -pt topic12_4_0 -u 0.011439685564491986 > ./result_10chains/node12_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_0 -p 469 -st none -pt topic12_5_0 -u 0.007991080412116325 > ./result_10chains/node12_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_0 -p 483 -st none -pt topic12_6_0 -u 0.022108247085808663 > ./result_10chains/node12_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_0 -p 497 -st none -pt topic12_7_0 -u 0.01440731787973204 > ./result_10chains/node12_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_8_0 -p 604 -st none -pt topic12_8_0 -u 0.0031843986760718007 > ./result_10chains/node12_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_9_0 -p 888 -st none -pt topic12_9_0 -u 0.0012895940974804142 > ./result_10chains/node12_9_0.txt &
sleep 10
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
    "./result_10chains/node12_0_0.txt 90"
    "./result_10chains/node12_0_2.txt 90"
    "./result_10chains/node12_1_0.txt 89"
    "./result_10chains/node12_1_2.txt 89"
    "./result_10chains/node12_2_0.txt 88"
    "./result_10chains/node12_2_2.txt 88"
    "./result_10chains/node12_3_0.txt 87"
    "./result_10chains/node12_3_2.txt 87"
    "./result_10chains/node12_4_0.txt 86"
    "./result_10chains/node12_4_2.txt 86"
    "./result_10chains/node12_5_0.txt 85"
    "./result_10chains/node12_5_2.txt 85"
    "./result_10chains/node12_6_0.txt 84"
    "./result_10chains/node12_6_2.txt 84"
    "./result_10chains/node12_7_0.txt 83"
    "./result_10chains/node12_7_2.txt 83"
    "./result_10chains/node12_8_0.txt 82"
    "./result_10chains/node12_8_2.txt 82"
    "./result_10chains/node12_9_0.txt 81"
    "./result_10chains/node12_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
