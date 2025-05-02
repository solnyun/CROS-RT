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
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_1 -p 17 -st topic96_0_0 -pt topic96_0_1 -u 0.00477540207103766 > ./result_10chains/node96_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_1 -p 31 -st topic96_1_0 -pt topic96_1_1 -u 0.00947300175641047 > ./result_10chains/node96_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_1 -p 120 -st topic96_2_0 -pt topic96_2_1 -u 0.02776683670857527 > ./result_10chains/node96_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_1 -p 158 -st topic96_3_0 -pt topic96_3_1 -u 0.011511536067478623 > ./result_10chains/node96_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_1 -p 193 -st topic96_4_0 -pt topic96_4_1 -u 0.014685974840232124 > ./result_10chains/node96_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_1 -p 671 -st topic96_5_0 -pt topic96_5_1 -u 0.0019942190638480017 > ./result_10chains/node96_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_1 -p 772 -st topic96_6_0 -pt topic96_6_1 -u 0.0016103081029545385 > ./result_10chains/node96_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_1 -p 822 -st topic96_7_0 -pt topic96_7_1 -u 0.00031006590811503976 > ./result_10chains/node96_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_8_1 -p 905 -st topic96_8_0 -pt topic96_8_1 -u 0.0023433805098365956 > ./result_10chains/node96_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_9_1 -p 997 -st topic96_9_0 -pt topic96_9_1 -u 0.004033141009421308 > ./result_10chains/node96_9_1.txt &
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
    "./result_10chains/node96_0_1.txt 90"
    "./result_10chains/node96_1_1.txt 89"
    "./result_10chains/node96_2_1.txt 88"
    "./result_10chains/node96_3_1.txt 87"
    "./result_10chains/node96_4_1.txt 86"
    "./result_10chains/node96_5_1.txt 85"
    "./result_10chains/node96_6_1.txt 84"
    "./result_10chains/node96_7_1.txt 83"
    "./result_10chains/node96_8_1.txt 82"
    "./result_10chains/node96_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
