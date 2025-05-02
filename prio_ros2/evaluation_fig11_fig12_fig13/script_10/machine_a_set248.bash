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
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_2 -p 120 -st topic248_0_1 -pt None -u 0.0006555078288487115 > ./result_10chains/node248_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_2 -p 523 -st topic248_1_1 -pt None -u 0.00020320092369202625 > ./result_10chains/node248_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_2 -p 536 -st topic248_2_1 -pt None -u 0.02658598506131693 > ./result_10chains/node248_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_2 -p 588 -st topic248_3_1 -pt None -u 0.01826117140465605 > ./result_10chains/node248_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_2 -p 649 -st topic248_4_1 -pt None -u 0.04355249574739306 > ./result_10chains/node248_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_2 -p 653 -st topic248_5_1 -pt None -u 0.03975022344477758 > ./result_10chains/node248_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_2 -p 703 -st topic248_6_1 -pt None -u 0.029136228628583283 > ./result_10chains/node248_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_2 -p 709 -st topic248_7_1 -pt None -u 0.0370167688985356 > ./result_10chains/node248_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_8_2 -p 861 -st topic248_8_1 -pt None -u 0.025898151262631314 > ./result_10chains/node248_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_9_2 -p 921 -st topic248_9_1 -pt None -u 0.0006609883108167656 > ./result_10chains/node248_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_0 -p 120 -st none -pt topic248_0_0 -u 0.0053344359717918954 > ./result_10chains/node248_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_0 -p 523 -st none -pt topic248_1_0 -u 0.008074377379744202 > ./result_10chains/node248_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_0 -p 536 -st none -pt topic248_2_0 -u 0.027168014863078127 > ./result_10chains/node248_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_0 -p 588 -st none -pt topic248_3_0 -u 0.004167348782031066 > ./result_10chains/node248_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_0 -p 649 -st none -pt topic248_4_0 -u 0.004132147507355355 > ./result_10chains/node248_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_0 -p 653 -st none -pt topic248_5_0 -u 0.004358421763269615 > ./result_10chains/node248_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_0 -p 703 -st none -pt topic248_6_0 -u 0.009746408487743802 > ./result_10chains/node248_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_0 -p 709 -st none -pt topic248_7_0 -u 0.014582131072604476 > ./result_10chains/node248_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_8_0 -p 861 -st none -pt topic248_8_0 -u 0.007480094169715061 > ./result_10chains/node248_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_9_0 -p 921 -st none -pt topic248_9_0 -u 0.00014213122530745519 > ./result_10chains/node248_9_0.txt &
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
    "./result_10chains/node248_0_0.txt 90"
    "./result_10chains/node248_0_2.txt 90"
    "./result_10chains/node248_1_0.txt 89"
    "./result_10chains/node248_1_2.txt 89"
    "./result_10chains/node248_2_0.txt 88"
    "./result_10chains/node248_2_2.txt 88"
    "./result_10chains/node248_3_0.txt 87"
    "./result_10chains/node248_3_2.txt 87"
    "./result_10chains/node248_4_0.txt 86"
    "./result_10chains/node248_4_2.txt 86"
    "./result_10chains/node248_5_0.txt 85"
    "./result_10chains/node248_5_2.txt 85"
    "./result_10chains/node248_6_0.txt 84"
    "./result_10chains/node248_6_2.txt 84"
    "./result_10chains/node248_7_0.txt 83"
    "./result_10chains/node248_7_2.txt 83"
    "./result_10chains/node248_8_0.txt 82"
    "./result_10chains/node248_8_2.txt 82"
    "./result_10chains/node248_9_0.txt 81"
    "./result_10chains/node248_9_2.txt 81"
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
