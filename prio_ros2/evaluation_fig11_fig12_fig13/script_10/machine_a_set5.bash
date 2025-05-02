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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_2 -p 32 -st topic5_0_1 -pt None -u 0.009469686599292093 > ./result_10chains/node5_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_2 -p 51 -st topic5_1_1 -pt None -u 0.000274290555864809 > ./result_10chains/node5_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_2 -p 434 -st topic5_2_1 -pt None -u 0.019827757137831414 > ./result_10chains/node5_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_2 -p 458 -st topic5_3_1 -pt None -u 0.0017445536771288905 > ./result_10chains/node5_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_2 -p 505 -st topic5_4_1 -pt None -u 0.0016512549170205615 > ./result_10chains/node5_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_2 -p 561 -st topic5_5_1 -pt None -u 0.016836756963633015 > ./result_10chains/node5_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_2 -p 657 -st topic5_6_1 -pt None -u 0.013105999493175091 > ./result_10chains/node5_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_2 -p 685 -st topic5_7_1 -pt None -u 0.001701451767944312 > ./result_10chains/node5_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_8_2 -p 703 -st topic5_8_1 -pt None -u 0.002172529572414761 > ./result_10chains/node5_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_9_2 -p 859 -st topic5_9_1 -pt None -u 0.09716198556291054 > ./result_10chains/node5_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_0 -p 32 -st none -pt topic5_0_0 -u 0.006158993774219079 > ./result_10chains/node5_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_0 -p 51 -st none -pt topic5_1_0 -u 0.00013228558809019741 > ./result_10chains/node5_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_0 -p 434 -st none -pt topic5_2_0 -u 0.040288098382557036 > ./result_10chains/node5_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_0 -p 458 -st none -pt topic5_3_0 -u 0.0041048432311910354 > ./result_10chains/node5_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_0 -p 505 -st none -pt topic5_4_0 -u 0.011785263436437876 > ./result_10chains/node5_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_0 -p 561 -st none -pt topic5_5_0 -u 0.008581544519121048 > ./result_10chains/node5_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_0 -p 657 -st none -pt topic5_6_0 -u 0.026272879178596054 > ./result_10chains/node5_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_0 -p 685 -st none -pt topic5_7_0 -u 0.024909948407122295 > ./result_10chains/node5_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_8_0 -p 703 -st none -pt topic5_8_0 -u 0.000385829436022056 > ./result_10chains/node5_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_9_0 -p 859 -st none -pt topic5_9_0 -u 0.012430472790887936 > ./result_10chains/node5_9_0.txt &
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
    "./result_10chains/node5_0_0.txt 90"
    "./result_10chains/node5_0_2.txt 90"
    "./result_10chains/node5_1_0.txt 89"
    "./result_10chains/node5_1_2.txt 89"
    "./result_10chains/node5_2_0.txt 88"
    "./result_10chains/node5_2_2.txt 88"
    "./result_10chains/node5_3_0.txt 87"
    "./result_10chains/node5_3_2.txt 87"
    "./result_10chains/node5_4_0.txt 86"
    "./result_10chains/node5_4_2.txt 86"
    "./result_10chains/node5_5_0.txt 85"
    "./result_10chains/node5_5_2.txt 85"
    "./result_10chains/node5_6_0.txt 84"
    "./result_10chains/node5_6_2.txt 84"
    "./result_10chains/node5_7_0.txt 83"
    "./result_10chains/node5_7_2.txt 83"
    "./result_10chains/node5_8_0.txt 82"
    "./result_10chains/node5_8_2.txt 82"
    "./result_10chains/node5_9_0.txt 81"
    "./result_10chains/node5_9_2.txt 81"
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
