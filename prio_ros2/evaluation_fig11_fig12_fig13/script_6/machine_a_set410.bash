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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_2 -p 203 -st topic410_0_1 -pt None -u 0.05523965353131749 > ./result_6chains/node410_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_2 -p 457 -st topic410_1_1 -pt None -u 0.0015502268789618356 > ./result_6chains/node410_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_2 -p 478 -st topic410_2_1 -pt None -u 0.0010604356763279643 > ./result_6chains/node410_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_2 -p 493 -st topic410_3_1 -pt None -u 0.04204715971997752 > ./result_6chains/node410_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_2 -p 516 -st topic410_4_1 -pt None -u 0.009789101168607456 > ./result_6chains/node410_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_2 -p 520 -st topic410_5_1 -pt None -u 0.020185529017748706 > ./result_6chains/node410_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_0 -p 203 -st none -pt topic410_0_0 -u 0.03153907977136633 > ./result_6chains/node410_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_0 -p 457 -st none -pt topic410_1_0 -u 0.07614203029101968 > ./result_6chains/node410_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_0 -p 478 -st none -pt topic410_2_0 -u 0.019639955713290136 > ./result_6chains/node410_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_0 -p 493 -st none -pt topic410_3_0 -u 0.01247079711807414 > ./result_6chains/node410_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_0 -p 516 -st none -pt topic410_4_0 -u 0.03506726866655116 > ./result_6chains/node410_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_0 -p 520 -st none -pt topic410_5_0 -u 0.049302629347413585 > ./result_6chains/node410_5_0.txt &
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
    "./result_6chains/node410_0_0.txt 90"
    "./result_6chains/node410_0_2.txt 90"
    "./result_6chains/node410_1_0.txt 89"
    "./result_6chains/node410_1_2.txt 89"
    "./result_6chains/node410_2_0.txt 88"
    "./result_6chains/node410_2_2.txt 88"
    "./result_6chains/node410_3_0.txt 87"
    "./result_6chains/node410_3_2.txt 87"
    "./result_6chains/node410_4_0.txt 86"
    "./result_6chains/node410_4_2.txt 86"
    "./result_6chains/node410_5_0.txt 85"
    "./result_6chains/node410_5_2.txt 85"
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
