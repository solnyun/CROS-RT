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
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_2 -p 186 -st topic23_0_1 -pt None -u 0.013917894862070457 > ./result_6chains/node23_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_2 -p 513 -st topic23_1_1 -pt None -u 0.04811536233737357 > ./result_6chains/node23_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_2 -p 552 -st topic23_2_1 -pt None -u 0.04315558278454776 > ./result_6chains/node23_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_2 -p 605 -st topic23_3_1 -pt None -u 0.013083175210221842 > ./result_6chains/node23_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_2 -p 843 -st topic23_4_1 -pt None -u 0.04496127479436607 > ./result_6chains/node23_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_2 -p 972 -st topic23_5_1 -pt None -u 0.0035478767780527504 > ./result_6chains/node23_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_0 -p 186 -st none -pt topic23_0_0 -u 0.03379244496413769 > ./result_6chains/node23_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_0 -p 513 -st none -pt topic23_1_0 -u 0.04598091821305389 > ./result_6chains/node23_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_0 -p 552 -st none -pt topic23_2_0 -u 0.0016952586201288977 > ./result_6chains/node23_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_0 -p 605 -st none -pt topic23_3_0 -u 0.0023448038380539105 > ./result_6chains/node23_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_0 -p 843 -st none -pt topic23_4_0 -u 0.04602004199553729 > ./result_6chains/node23_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_0 -p 972 -st none -pt topic23_5_0 -u 0.00023168658117844743 > ./result_6chains/node23_5_0.txt &
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
    "./result_6chains/node23_0_0.txt 90"
    "./result_6chains/node23_0_2.txt 90"
    "./result_6chains/node23_1_0.txt 89"
    "./result_6chains/node23_1_2.txt 89"
    "./result_6chains/node23_2_0.txt 88"
    "./result_6chains/node23_2_2.txt 88"
    "./result_6chains/node23_3_0.txt 87"
    "./result_6chains/node23_3_2.txt 87"
    "./result_6chains/node23_4_0.txt 86"
    "./result_6chains/node23_4_2.txt 86"
    "./result_6chains/node23_5_0.txt 85"
    "./result_6chains/node23_5_2.txt 85"
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
