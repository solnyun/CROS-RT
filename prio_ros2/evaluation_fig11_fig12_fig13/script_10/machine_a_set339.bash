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
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_2 -p 114 -st topic339_0_1 -pt None -u 0.01131551122380825 > ./result_10chains/node339_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_2 -p 168 -st topic339_1_1 -pt None -u 0.010182626162088315 > ./result_10chains/node339_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_2 -p 272 -st topic339_2_1 -pt None -u 0.00702157777818202 > ./result_10chains/node339_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_2 -p 292 -st topic339_3_1 -pt None -u 0.014369240648969328 > ./result_10chains/node339_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_2 -p 418 -st topic339_4_1 -pt None -u 0.012948993654240126 > ./result_10chains/node339_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_2 -p 439 -st topic339_5_1 -pt None -u 0.000883973410900657 > ./result_10chains/node339_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_2 -p 670 -st topic339_6_1 -pt None -u 0.0056528815999796755 > ./result_10chains/node339_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_2 -p 742 -st topic339_7_1 -pt None -u 0.010669928907235601 > ./result_10chains/node339_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_8_2 -p 809 -st topic339_8_1 -pt None -u 0.0002731276225456797 > ./result_10chains/node339_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_9_2 -p 981 -st topic339_9_1 -pt None -u 0.028107003756671335 > ./result_10chains/node339_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_0 -p 114 -st none -pt topic339_0_0 -u 0.007104671037416688 > ./result_10chains/node339_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_0 -p 168 -st none -pt topic339_1_0 -u 0.028835853523829502 > ./result_10chains/node339_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_0 -p 272 -st none -pt topic339_2_0 -u 0.041691693968424315 > ./result_10chains/node339_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_0 -p 292 -st none -pt topic339_3_0 -u 0.018798297096706496 > ./result_10chains/node339_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_0 -p 418 -st none -pt topic339_4_0 -u 0.0028628363169951876 > ./result_10chains/node339_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_0 -p 439 -st none -pt topic339_5_0 -u 0.05128371206221524 > ./result_10chains/node339_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_0 -p 670 -st none -pt topic339_6_0 -u 0.004317732333049912 > ./result_10chains/node339_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_0 -p 742 -st none -pt topic339_7_0 -u 0.013107620653187435 > ./result_10chains/node339_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_8_0 -p 809 -st none -pt topic339_8_0 -u 0.0033060894614700548 > ./result_10chains/node339_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_9_0 -p 981 -st none -pt topic339_9_0 -u 0.00843194217996708 > ./result_10chains/node339_9_0.txt &
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
    "./result_10chains/node339_0_0.txt 90"
    "./result_10chains/node339_0_2.txt 90"
    "./result_10chains/node339_1_0.txt 89"
    "./result_10chains/node339_1_2.txt 89"
    "./result_10chains/node339_2_0.txt 88"
    "./result_10chains/node339_2_2.txt 88"
    "./result_10chains/node339_3_0.txt 87"
    "./result_10chains/node339_3_2.txt 87"
    "./result_10chains/node339_4_0.txt 86"
    "./result_10chains/node339_4_2.txt 86"
    "./result_10chains/node339_5_0.txt 85"
    "./result_10chains/node339_5_2.txt 85"
    "./result_10chains/node339_6_0.txt 84"
    "./result_10chains/node339_6_2.txt 84"
    "./result_10chains/node339_7_0.txt 83"
    "./result_10chains/node339_7_2.txt 83"
    "./result_10chains/node339_8_0.txt 82"
    "./result_10chains/node339_8_2.txt 82"
    "./result_10chains/node339_9_0.txt 81"
    "./result_10chains/node339_9_2.txt 81"
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
