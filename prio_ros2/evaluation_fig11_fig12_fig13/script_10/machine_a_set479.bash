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
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_2 -p 33 -st topic479_0_1 -pt None -u 0.008051518592227636 > ./result_10chains/node479_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_2 -p 46 -st topic479_1_1 -pt None -u 0.008420444208484812 > ./result_10chains/node479_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_2 -p 162 -st topic479_2_1 -pt None -u 0.0031760627327679924 > ./result_10chains/node479_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_2 -p 178 -st topic479_3_1 -pt None -u 0.00022321627611981976 > ./result_10chains/node479_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_2 -p 262 -st topic479_4_1 -pt None -u 0.0033033074918775718 > ./result_10chains/node479_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_2 -p 465 -st topic479_5_1 -pt None -u 0.0018847394337890844 > ./result_10chains/node479_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_2 -p 772 -st topic479_6_1 -pt None -u 0.026551777346947664 > ./result_10chains/node479_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_2 -p 840 -st topic479_7_1 -pt None -u 0.05820782640255667 > ./result_10chains/node479_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_8_2 -p 878 -st topic479_8_1 -pt None -u 0.02612402125447251 > ./result_10chains/node479_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_9_2 -p 927 -st topic479_9_1 -pt None -u 0.01258673171296239 > ./result_10chains/node479_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_0 -p 33 -st none -pt topic479_0_0 -u 0.008408778929603344 > ./result_10chains/node479_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_0 -p 46 -st none -pt topic479_1_0 -u 0.02143251673921509 > ./result_10chains/node479_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_0 -p 162 -st none -pt topic479_2_0 -u 0.006575968446800584 > ./result_10chains/node479_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_0 -p 178 -st none -pt topic479_3_0 -u 0.012405388382877136 > ./result_10chains/node479_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_0 -p 262 -st none -pt topic479_4_0 -u 0.0005672945079843172 > ./result_10chains/node479_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_0 -p 465 -st none -pt topic479_5_0 -u 0.05110758698476914 > ./result_10chains/node479_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_0 -p 772 -st none -pt topic479_6_0 -u 0.0033407456803804525 > ./result_10chains/node479_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_0 -p 840 -st none -pt topic479_7_0 -u 0.011292869349459222 > ./result_10chains/node479_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_8_0 -p 878 -st none -pt topic479_8_0 -u 0.038544954692432604 > ./result_10chains/node479_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_9_0 -p 927 -st none -pt topic479_9_0 -u 0.0261701352510198 > ./result_10chains/node479_9_0.txt &
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
    "./result_10chains/node479_0_0.txt 90"
    "./result_10chains/node479_0_2.txt 90"
    "./result_10chains/node479_1_0.txt 89"
    "./result_10chains/node479_1_2.txt 89"
    "./result_10chains/node479_2_0.txt 88"
    "./result_10chains/node479_2_2.txt 88"
    "./result_10chains/node479_3_0.txt 87"
    "./result_10chains/node479_3_2.txt 87"
    "./result_10chains/node479_4_0.txt 86"
    "./result_10chains/node479_4_2.txt 86"
    "./result_10chains/node479_5_0.txt 85"
    "./result_10chains/node479_5_2.txt 85"
    "./result_10chains/node479_6_0.txt 84"
    "./result_10chains/node479_6_2.txt 84"
    "./result_10chains/node479_7_0.txt 83"
    "./result_10chains/node479_7_2.txt 83"
    "./result_10chains/node479_8_0.txt 82"
    "./result_10chains/node479_8_2.txt 82"
    "./result_10chains/node479_9_0.txt 81"
    "./result_10chains/node479_9_2.txt 81"
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
