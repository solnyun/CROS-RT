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
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_2 -p 121 -st topic55_0_1 -pt None -u 0.0038430884778985486 > ./result_10chains/node55_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_2 -p 206 -st topic55_1_1 -pt None -u 0.011060393226857756 > ./result_10chains/node55_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_2 -p 373 -st topic55_2_1 -pt None -u 0.009911259102052206 > ./result_10chains/node55_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_2 -p 548 -st topic55_3_1 -pt None -u 0.009416714836493312 > ./result_10chains/node55_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_2 -p 581 -st topic55_4_1 -pt None -u 0.010787589226397554 > ./result_10chains/node55_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_2 -p 586 -st topic55_5_1 -pt None -u 0.009144521614288303 > ./result_10chains/node55_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_6_2 -p 665 -st topic55_6_1 -pt None -u 0.00037441736885146515 > ./result_10chains/node55_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_7_2 -p 734 -st topic55_7_1 -pt None -u 0.008777257903239938 > ./result_10chains/node55_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_8_2 -p 771 -st topic55_8_1 -pt None -u 0.013944020033778398 > ./result_10chains/node55_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_9_2 -p 929 -st topic55_9_1 -pt None -u 0.10948999148010319 > ./result_10chains/node55_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_0 -p 121 -st none -pt topic55_0_0 -u 0.003228747138529997 > ./result_10chains/node55_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_0 -p 206 -st none -pt topic55_1_0 -u 0.03459287789560267 > ./result_10chains/node55_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_0 -p 373 -st none -pt topic55_2_0 -u 0.0106479493513838 > ./result_10chains/node55_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_0 -p 548 -st none -pt topic55_3_0 -u 0.04150198010939843 > ./result_10chains/node55_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_0 -p 581 -st none -pt topic55_4_0 -u 0.01135686221035731 > ./result_10chains/node55_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_0 -p 586 -st none -pt topic55_5_0 -u 0.02104639025035565 > ./result_10chains/node55_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_6_0 -p 665 -st none -pt topic55_6_0 -u 0.00030636434262862333 > ./result_10chains/node55_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_7_0 -p 734 -st none -pt topic55_7_0 -u 0.011083695181999642 > ./result_10chains/node55_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_8_0 -p 771 -st none -pt topic55_8_0 -u 0.012833762732334109 > ./result_10chains/node55_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_9_0 -p 929 -st none -pt topic55_9_0 -u 0.008404548102348683 > ./result_10chains/node55_9_0.txt &
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
    "./result_10chains/node55_0_0.txt 90"
    "./result_10chains/node55_0_2.txt 90"
    "./result_10chains/node55_1_0.txt 89"
    "./result_10chains/node55_1_2.txt 89"
    "./result_10chains/node55_2_0.txt 88"
    "./result_10chains/node55_2_2.txt 88"
    "./result_10chains/node55_3_0.txt 87"
    "./result_10chains/node55_3_2.txt 87"
    "./result_10chains/node55_4_0.txt 86"
    "./result_10chains/node55_4_2.txt 86"
    "./result_10chains/node55_5_0.txt 85"
    "./result_10chains/node55_5_2.txt 85"
    "./result_10chains/node55_6_0.txt 84"
    "./result_10chains/node55_6_2.txt 84"
    "./result_10chains/node55_7_0.txt 83"
    "./result_10chains/node55_7_2.txt 83"
    "./result_10chains/node55_8_0.txt 82"
    "./result_10chains/node55_8_2.txt 82"
    "./result_10chains/node55_9_0.txt 81"
    "./result_10chains/node55_9_2.txt 81"
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
