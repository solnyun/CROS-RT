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
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_2 -p 58 -st topic170_0_1 -pt None -u 0.0006237495827552397 > ./result_10chains/node170_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_2 -p 295 -st topic170_1_1 -pt None -u 0.03971687117133871 > ./result_10chains/node170_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_2 -p 344 -st topic170_2_1 -pt None -u 0.00029218725138163704 > ./result_10chains/node170_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_2 -p 424 -st topic170_3_1 -pt None -u 0.0002909125100806209 > ./result_10chains/node170_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_2 -p 436 -st topic170_4_1 -pt None -u 0.013700432051087563 > ./result_10chains/node170_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_2 -p 569 -st topic170_5_1 -pt None -u 0.0037923020846723776 > ./result_10chains/node170_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_2 -p 699 -st topic170_6_1 -pt None -u 0.025712927309855083 > ./result_10chains/node170_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_2 -p 774 -st topic170_7_1 -pt None -u 0.017590203480074035 > ./result_10chains/node170_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_8_2 -p 821 -st topic170_8_1 -pt None -u 0.014223268006820503 > ./result_10chains/node170_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_9_2 -p 995 -st topic170_9_1 -pt None -u 0.011624575832524662 > ./result_10chains/node170_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_0 -p 58 -st none -pt topic170_0_0 -u 0.02504231172422028 > ./result_10chains/node170_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_0 -p 295 -st none -pt topic170_1_0 -u 0.009162600917828723 > ./result_10chains/node170_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_0 -p 344 -st none -pt topic170_2_0 -u 0.05097273233060157 > ./result_10chains/node170_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_0 -p 424 -st none -pt topic170_3_0 -u 0.04083810751881162 > ./result_10chains/node170_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_0 -p 436 -st none -pt topic170_4_0 -u 0.0002963993491506556 > ./result_10chains/node170_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_0 -p 569 -st none -pt topic170_5_0 -u 0.035296573124173974 > ./result_10chains/node170_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_0 -p 699 -st none -pt topic170_6_0 -u 0.03051730285992174 > ./result_10chains/node170_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_0 -p 774 -st none -pt topic170_7_0 -u 0.01120775492199938 > ./result_10chains/node170_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_8_0 -p 821 -st none -pt topic170_8_0 -u 0.021775102126216854 > ./result_10chains/node170_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_9_0 -p 995 -st none -pt topic170_9_0 -u 0.008089355441612767 > ./result_10chains/node170_9_0.txt &
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
    "./result_10chains/node170_0_0.txt 90"
    "./result_10chains/node170_0_2.txt 90"
    "./result_10chains/node170_1_0.txt 89"
    "./result_10chains/node170_1_2.txt 89"
    "./result_10chains/node170_2_0.txt 88"
    "./result_10chains/node170_2_2.txt 88"
    "./result_10chains/node170_3_0.txt 87"
    "./result_10chains/node170_3_2.txt 87"
    "./result_10chains/node170_4_0.txt 86"
    "./result_10chains/node170_4_2.txt 86"
    "./result_10chains/node170_5_0.txt 85"
    "./result_10chains/node170_5_2.txt 85"
    "./result_10chains/node170_6_0.txt 84"
    "./result_10chains/node170_6_2.txt 84"
    "./result_10chains/node170_7_0.txt 83"
    "./result_10chains/node170_7_2.txt 83"
    "./result_10chains/node170_8_0.txt 82"
    "./result_10chains/node170_8_2.txt 82"
    "./result_10chains/node170_9_0.txt 81"
    "./result_10chains/node170_9_2.txt 81"
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
