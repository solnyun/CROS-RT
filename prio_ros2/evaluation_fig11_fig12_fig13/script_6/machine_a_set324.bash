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
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_2 -p 144 -st topic324_0_1 -pt None -u 0.05412001674095518 > ./result_6chains/node324_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_2 -p 469 -st topic324_1_1 -pt None -u 0.002571115413030012 > ./result_6chains/node324_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_2 -p 620 -st topic324_2_1 -pt None -u 0.019273766067610054 > ./result_6chains/node324_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_2 -p 818 -st topic324_3_1 -pt None -u 0.07757368918881338 > ./result_6chains/node324_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_2 -p 940 -st topic324_4_1 -pt None -u 0.05732760314176092 > ./result_6chains/node324_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_2 -p 956 -st topic324_5_1 -pt None -u 0.006347346007088384 > ./result_6chains/node324_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_0 -p 144 -st none -pt topic324_0_0 -u 0.0038418869505081332 > ./result_6chains/node324_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_0 -p 469 -st none -pt topic324_1_0 -u 0.019026758233757934 > ./result_6chains/node324_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_0 -p 620 -st none -pt topic324_2_0 -u 0.0011860606841599952 > ./result_6chains/node324_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_0 -p 818 -st none -pt topic324_3_0 -u 0.012216377199843753 > ./result_6chains/node324_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_0 -p 940 -st none -pt topic324_4_0 -u 0.06049023829450448 > ./result_6chains/node324_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_0 -p 956 -st none -pt topic324_5_0 -u 0.02276646572235473 > ./result_6chains/node324_5_0.txt &
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
    "./result_6chains/node324_0_0.txt 90"
    "./result_6chains/node324_0_2.txt 90"
    "./result_6chains/node324_1_0.txt 89"
    "./result_6chains/node324_1_2.txt 89"
    "./result_6chains/node324_2_0.txt 88"
    "./result_6chains/node324_2_2.txt 88"
    "./result_6chains/node324_3_0.txt 87"
    "./result_6chains/node324_3_2.txt 87"
    "./result_6chains/node324_4_0.txt 86"
    "./result_6chains/node324_4_2.txt 86"
    "./result_6chains/node324_5_0.txt 85"
    "./result_6chains/node324_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
