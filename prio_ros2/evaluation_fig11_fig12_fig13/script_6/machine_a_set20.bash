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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_2 -p 288 -st topic20_0_1 -pt None -u 0.0003138229538514614 > ./result_6chains/node20_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_2 -p 396 -st topic20_1_1 -pt None -u 0.007295563412325401 > ./result_6chains/node20_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_2 -p 521 -st topic20_2_1 -pt None -u 0.02271630116010276 > ./result_6chains/node20_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_2 -p 640 -st topic20_3_1 -pt None -u 0.057720591718530084 > ./result_6chains/node20_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_2 -p 676 -st topic20_4_1 -pt None -u 0.0072372773800781914 > ./result_6chains/node20_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_2 -p 731 -st topic20_5_1 -pt None -u 0.033698388069241456 > ./result_6chains/node20_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_0 -p 288 -st none -pt topic20_0_0 -u 0.023298276061954393 > ./result_6chains/node20_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_0 -p 396 -st none -pt topic20_1_0 -u 0.05211981429261697 > ./result_6chains/node20_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_0 -p 521 -st none -pt topic20_2_0 -u 0.010951454041160213 > ./result_6chains/node20_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_0 -p 640 -st none -pt topic20_3_0 -u 0.001345425442048881 > ./result_6chains/node20_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_0 -p 676 -st none -pt topic20_4_0 -u 0.018297959272509934 > ./result_6chains/node20_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_0 -p 731 -st none -pt topic20_5_0 -u 0.06216530020572447 > ./result_6chains/node20_5_0.txt &
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
    "./result_6chains/node20_0_0.txt 90"
    "./result_6chains/node20_0_2.txt 90"
    "./result_6chains/node20_1_0.txt 89"
    "./result_6chains/node20_1_2.txt 89"
    "./result_6chains/node20_2_0.txt 88"
    "./result_6chains/node20_2_2.txt 88"
    "./result_6chains/node20_3_0.txt 87"
    "./result_6chains/node20_3_2.txt 87"
    "./result_6chains/node20_4_0.txt 86"
    "./result_6chains/node20_4_2.txt 86"
    "./result_6chains/node20_5_0.txt 85"
    "./result_6chains/node20_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
