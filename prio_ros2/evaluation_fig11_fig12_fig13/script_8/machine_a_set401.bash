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
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_2 -p 139 -st topic401_0_1 -pt None -u 0.033907094123527104 > ./result_8chains/node401_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_2 -p 350 -st topic401_1_1 -pt None -u 0.058010415013454386 > ./result_8chains/node401_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_2 -p 430 -st topic401_2_1 -pt None -u 0.0032820952438218365 > ./result_8chains/node401_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_2 -p 433 -st topic401_3_1 -pt None -u 0.0007572193971341346 > ./result_8chains/node401_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_2 -p 460 -st topic401_4_1 -pt None -u 0.04241495116144817 > ./result_8chains/node401_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_2 -p 735 -st topic401_5_1 -pt None -u 0.014859618101582012 > ./result_8chains/node401_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_2 -p 942 -st topic401_6_1 -pt None -u 0.0015664600930806113 > ./result_8chains/node401_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_2 -p 955 -st topic401_7_1 -pt None -u 0.003827693590712735 > ./result_8chains/node401_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_0 -p 139 -st none -pt topic401_0_0 -u 0.0022147311686993576 > ./result_8chains/node401_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_0 -p 350 -st none -pt topic401_1_0 -u 0.02644492615609434 > ./result_8chains/node401_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_0 -p 430 -st none -pt topic401_2_0 -u 0.023021070941326216 > ./result_8chains/node401_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_0 -p 433 -st none -pt topic401_3_0 -u 0.04218761356183576 > ./result_8chains/node401_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_0 -p 460 -st none -pt topic401_4_0 -u 0.052839876178848 > ./result_8chains/node401_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_0 -p 735 -st none -pt topic401_5_0 -u 0.0035869862681407183 > ./result_8chains/node401_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_0 -p 942 -st none -pt topic401_6_0 -u 0.020906637347513968 > ./result_8chains/node401_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_0 -p 955 -st none -pt topic401_7_0 -u 0.03018521744310909 > ./result_8chains/node401_7_0.txt &
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
    "./result_8chains/node401_0_0.txt 90"
    "./result_8chains/node401_0_2.txt 90"
    "./result_8chains/node401_1_0.txt 89"
    "./result_8chains/node401_1_2.txt 89"
    "./result_8chains/node401_2_0.txt 88"
    "./result_8chains/node401_2_2.txt 88"
    "./result_8chains/node401_3_0.txt 87"
    "./result_8chains/node401_3_2.txt 87"
    "./result_8chains/node401_4_0.txt 86"
    "./result_8chains/node401_4_2.txt 86"
    "./result_8chains/node401_5_0.txt 85"
    "./result_8chains/node401_5_2.txt 85"
    "./result_8chains/node401_6_0.txt 84"
    "./result_8chains/node401_6_2.txt 84"
    "./result_8chains/node401_7_0.txt 83"
    "./result_8chains/node401_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
