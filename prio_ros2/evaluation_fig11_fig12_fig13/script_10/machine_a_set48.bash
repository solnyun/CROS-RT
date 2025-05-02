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
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_2 -p 91 -st topic48_0_1 -pt None -u 0.03706064961420147 > ./result_10chains/node48_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_2 -p 113 -st topic48_1_1 -pt None -u 0.003712509738493075 > ./result_10chains/node48_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_2 -p 189 -st topic48_2_1 -pt None -u 0.004058690605419524 > ./result_10chains/node48_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_2 -p 480 -st topic48_3_1 -pt None -u 0.0007712122097556229 > ./result_10chains/node48_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_2 -p 488 -st topic48_4_1 -pt None -u 0.04224587061375959 > ./result_10chains/node48_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_2 -p 507 -st topic48_5_1 -pt None -u 0.0050848094073723815 > ./result_10chains/node48_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_6_2 -p 597 -st topic48_6_1 -pt None -u 0.022781754972333118 > ./result_10chains/node48_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_7_2 -p 622 -st topic48_7_1 -pt None -u 0.02545151380273361 > ./result_10chains/node48_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_8_2 -p 751 -st topic48_8_1 -pt None -u 0.019981145917431692 > ./result_10chains/node48_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_9_2 -p 778 -st topic48_9_1 -pt None -u 0.006506086525028699 > ./result_10chains/node48_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_0 -p 91 -st none -pt topic48_0_0 -u 0.003172653012386839 > ./result_10chains/node48_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_0 -p 113 -st none -pt topic48_1_0 -u 0.01621140347472788 > ./result_10chains/node48_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_0 -p 189 -st none -pt topic48_2_0 -u 0.0011561736823171853 > ./result_10chains/node48_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_0 -p 480 -st none -pt topic48_3_0 -u 0.012874169315113149 > ./result_10chains/node48_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_0 -p 488 -st none -pt topic48_4_0 -u 0.007726973909416679 > ./result_10chains/node48_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_0 -p 507 -st none -pt topic48_5_0 -u 0.019842054675434845 > ./result_10chains/node48_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_6_0 -p 597 -st none -pt topic48_6_0 -u 0.0038876615778151435 > ./result_10chains/node48_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_7_0 -p 622 -st none -pt topic48_7_0 -u 0.00766255970994667 > ./result_10chains/node48_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node48_8_0 -p 751 -st none -pt topic48_8_0 -u 0.03295020559816178 > ./result_10chains/node48_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node48_9_0 -p 778 -st none -pt topic48_9_0 -u 0.008392859235094396 > ./result_10chains/node48_9_0.txt &
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
    "./result_10chains/node48_0_0.txt 90"
    "./result_10chains/node48_0_2.txt 90"
    "./result_10chains/node48_1_0.txt 89"
    "./result_10chains/node48_1_2.txt 89"
    "./result_10chains/node48_2_0.txt 88"
    "./result_10chains/node48_2_2.txt 88"
    "./result_10chains/node48_3_0.txt 87"
    "./result_10chains/node48_3_2.txt 87"
    "./result_10chains/node48_4_0.txt 86"
    "./result_10chains/node48_4_2.txt 86"
    "./result_10chains/node48_5_0.txt 85"
    "./result_10chains/node48_5_2.txt 85"
    "./result_10chains/node48_6_0.txt 84"
    "./result_10chains/node48_6_2.txt 84"
    "./result_10chains/node48_7_0.txt 83"
    "./result_10chains/node48_7_2.txt 83"
    "./result_10chains/node48_8_0.txt 82"
    "./result_10chains/node48_8_2.txt 82"
    "./result_10chains/node48_9_0.txt 81"
    "./result_10chains/node48_9_2.txt 81"
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
