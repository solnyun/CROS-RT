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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_2 -p 202 -st topic123_0_1 -pt None -u 0.07262261820845917 > ./result_6chains/node123_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_2 -p 420 -st topic123_1_1 -pt None -u 0.026860999611526937 > ./result_6chains/node123_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_2 -p 465 -st topic123_2_1 -pt None -u 0.0023128732635421256 > ./result_6chains/node123_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_2 -p 486 -st topic123_3_1 -pt None -u 0.032210398624851505 > ./result_6chains/node123_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_2 -p 738 -st topic123_4_1 -pt None -u 0.06659058137257244 > ./result_6chains/node123_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_2 -p 756 -st topic123_5_1 -pt None -u 0.012153734136684063 > ./result_6chains/node123_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_0 -p 202 -st none -pt topic123_0_0 -u 0.01922315358304305 > ./result_6chains/node123_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_0 -p 420 -st none -pt topic123_1_0 -u 0.007919042918976882 > ./result_6chains/node123_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_0 -p 465 -st none -pt topic123_2_0 -u 0.00023186203644698367 > ./result_6chains/node123_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_0 -p 486 -st none -pt topic123_3_0 -u 0.006598168312867081 > ./result_6chains/node123_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_0 -p 738 -st none -pt topic123_4_0 -u 0.0017325724685047228 > ./result_6chains/node123_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_0 -p 756 -st none -pt topic123_5_0 -u 0.010278929180630003 > ./result_6chains/node123_5_0.txt &
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
    "./result_6chains/node123_0_0.txt 90"
    "./result_6chains/node123_0_2.txt 90"
    "./result_6chains/node123_1_0.txt 89"
    "./result_6chains/node123_1_2.txt 89"
    "./result_6chains/node123_2_0.txt 88"
    "./result_6chains/node123_2_2.txt 88"
    "./result_6chains/node123_3_0.txt 87"
    "./result_6chains/node123_3_2.txt 87"
    "./result_6chains/node123_4_0.txt 86"
    "./result_6chains/node123_4_2.txt 86"
    "./result_6chains/node123_5_0.txt 85"
    "./result_6chains/node123_5_2.txt 85"
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
