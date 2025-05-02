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
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_2 -p 82 -st topic439_0_1 -pt None -u 0.00589923210906268 > ./result_10chains/node439_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_2 -p 311 -st topic439_1_1 -pt None -u 0.031075072957046923 > ./result_10chains/node439_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_2 -p 358 -st topic439_2_1 -pt None -u 0.014741942503353145 > ./result_10chains/node439_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_2 -p 463 -st topic439_3_1 -pt None -u 0.01046709465416612 > ./result_10chains/node439_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_2 -p 536 -st topic439_4_1 -pt None -u 0.010121332425878732 > ./result_10chains/node439_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_2 -p 542 -st topic439_5_1 -pt None -u 0.04395279206079636 > ./result_10chains/node439_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_6_2 -p 569 -st topic439_6_1 -pt None -u 0.009478635844218444 > ./result_10chains/node439_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_7_2 -p 598 -st topic439_7_1 -pt None -u 0.006859564364538745 > ./result_10chains/node439_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_8_2 -p 635 -st topic439_8_1 -pt None -u 0.006248304532182648 > ./result_10chains/node439_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_9_2 -p 719 -st topic439_9_1 -pt None -u 0.0002395132638851989 > ./result_10chains/node439_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_0 -p 82 -st none -pt topic439_0_0 -u 0.07402304864954495 > ./result_10chains/node439_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_0 -p 311 -st none -pt topic439_1_0 -u 0.005094774429692417 > ./result_10chains/node439_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_0 -p 358 -st none -pt topic439_2_0 -u 0.008242137361593016 > ./result_10chains/node439_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_0 -p 463 -st none -pt topic439_3_0 -u 0.0008807699243995604 > ./result_10chains/node439_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_0 -p 536 -st none -pt topic439_4_0 -u 0.002977114772040046 > ./result_10chains/node439_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_0 -p 542 -st none -pt topic439_5_0 -u 0.02350912048841386 > ./result_10chains/node439_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_6_0 -p 569 -st none -pt topic439_6_0 -u 0.030538334265521203 > ./result_10chains/node439_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_7_0 -p 598 -st none -pt topic439_7_0 -u 0.010223684584242651 > ./result_10chains/node439_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_8_0 -p 635 -st none -pt topic439_8_0 -u 0.01590370102083575 > ./result_10chains/node439_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_9_0 -p 719 -st none -pt topic439_9_0 -u 0.0077464597373193625 > ./result_10chains/node439_9_0.txt &
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
    "./result_10chains/node439_0_0.txt 90"
    "./result_10chains/node439_0_2.txt 90"
    "./result_10chains/node439_1_0.txt 89"
    "./result_10chains/node439_1_2.txt 89"
    "./result_10chains/node439_2_0.txt 88"
    "./result_10chains/node439_2_2.txt 88"
    "./result_10chains/node439_3_0.txt 87"
    "./result_10chains/node439_3_2.txt 87"
    "./result_10chains/node439_4_0.txt 86"
    "./result_10chains/node439_4_2.txt 86"
    "./result_10chains/node439_5_0.txt 85"
    "./result_10chains/node439_5_2.txt 85"
    "./result_10chains/node439_6_0.txt 84"
    "./result_10chains/node439_6_2.txt 84"
    "./result_10chains/node439_7_0.txt 83"
    "./result_10chains/node439_7_2.txt 83"
    "./result_10chains/node439_8_0.txt 82"
    "./result_10chains/node439_8_2.txt 82"
    "./result_10chains/node439_9_0.txt 81"
    "./result_10chains/node439_9_2.txt 81"
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
