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
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_2 -p 56 -st topic4_0_1 -pt None -u 0.033739910944019624 > ./result_10chains/node4_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_2 -p 138 -st topic4_1_1 -pt None -u 0.010788105393988778 > ./result_10chains/node4_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_2 -p 142 -st topic4_2_1 -pt None -u 0.02614902777348832 > ./result_10chains/node4_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_2 -p 154 -st topic4_3_1 -pt None -u 0.007165086021393596 > ./result_10chains/node4_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_2 -p 173 -st topic4_4_1 -pt None -u 0.03652384053843763 > ./result_10chains/node4_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_2 -p 272 -st topic4_5_1 -pt None -u 0.02495881316043702 > ./result_10chains/node4_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_6_2 -p 474 -st topic4_6_1 -pt None -u 0.0075555821539197016 > ./result_10chains/node4_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_7_2 -p 646 -st topic4_7_1 -pt None -u 0.0082645564988537 > ./result_10chains/node4_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_8_2 -p 680 -st topic4_8_1 -pt None -u 0.00010533760760041144 > ./result_10chains/node4_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_9_2 -p 784 -st topic4_9_1 -pt None -u 0.026083931794376874 > ./result_10chains/node4_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_0 -p 56 -st none -pt topic4_0_0 -u 0.03283745279671041 > ./result_10chains/node4_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_0 -p 138 -st none -pt topic4_1_0 -u 0.030567341972596473 > ./result_10chains/node4_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_0 -p 142 -st none -pt topic4_2_0 -u 0.005741619061680914 > ./result_10chains/node4_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_0 -p 154 -st none -pt topic4_3_0 -u 0.01904661876414504 > ./result_10chains/node4_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_0 -p 173 -st none -pt topic4_4_0 -u 0.022497829598754987 > ./result_10chains/node4_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_0 -p 272 -st none -pt topic4_5_0 -u 0.0264442751874297 > ./result_10chains/node4_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_6_0 -p 474 -st none -pt topic4_6_0 -u 0.020287380471760708 > ./result_10chains/node4_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_7_0 -p 646 -st none -pt topic4_7_0 -u 0.025497169517869303 > ./result_10chains/node4_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_8_0 -p 680 -st none -pt topic4_8_0 -u 0.02510188305938211 > ./result_10chains/node4_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_9_0 -p 784 -st none -pt topic4_9_0 -u 0.005539256479785766 > ./result_10chains/node4_9_0.txt &
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
    "./result_10chains/node4_0_0.txt 90"
    "./result_10chains/node4_0_2.txt 90"
    "./result_10chains/node4_1_0.txt 89"
    "./result_10chains/node4_1_2.txt 89"
    "./result_10chains/node4_2_0.txt 88"
    "./result_10chains/node4_2_2.txt 88"
    "./result_10chains/node4_3_0.txt 87"
    "./result_10chains/node4_3_2.txt 87"
    "./result_10chains/node4_4_0.txt 86"
    "./result_10chains/node4_4_2.txt 86"
    "./result_10chains/node4_5_0.txt 85"
    "./result_10chains/node4_5_2.txt 85"
    "./result_10chains/node4_6_0.txt 84"
    "./result_10chains/node4_6_2.txt 84"
    "./result_10chains/node4_7_0.txt 83"
    "./result_10chains/node4_7_2.txt 83"
    "./result_10chains/node4_8_0.txt 82"
    "./result_10chains/node4_8_2.txt 82"
    "./result_10chains/node4_9_0.txt 81"
    "./result_10chains/node4_9_2.txt 81"
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
