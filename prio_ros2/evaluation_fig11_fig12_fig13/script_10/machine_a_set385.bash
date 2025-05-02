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
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_2 -p 82 -st topic385_0_1 -pt None -u 0.01781134377834953 > ./result_10chains/node385_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_2 -p 183 -st topic385_1_1 -pt None -u 0.015056746079535055 > ./result_10chains/node385_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_2 -p 256 -st topic385_2_1 -pt None -u 0.0052194868835481745 > ./result_10chains/node385_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_2 -p 580 -st topic385_3_1 -pt None -u 0.002900985933797673 > ./result_10chains/node385_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_2 -p 744 -st topic385_4_1 -pt None -u 0.0008548817687480392 > ./result_10chains/node385_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_2 -p 751 -st topic385_5_1 -pt None -u 0.041366405951104024 > ./result_10chains/node385_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_6_2 -p 782 -st topic385_6_1 -pt None -u 0.008287717694985916 > ./result_10chains/node385_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_7_2 -p 910 -st topic385_7_1 -pt None -u 0.013176710007756144 > ./result_10chains/node385_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_8_2 -p 974 -st topic385_8_1 -pt None -u 0.0017593231565947304 > ./result_10chains/node385_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_9_2 -p 999 -st topic385_9_1 -pt None -u 0.003052347678348863 > ./result_10chains/node385_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_0 -p 82 -st none -pt topic385_0_0 -u 0.010170140448014009 > ./result_10chains/node385_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_0 -p 183 -st none -pt topic385_1_0 -u 0.00232469414105424 > ./result_10chains/node385_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_0 -p 256 -st none -pt topic385_2_0 -u 0.03428829758373142 > ./result_10chains/node385_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_0 -p 580 -st none -pt topic385_3_0 -u 0.05718862342976594 > ./result_10chains/node385_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_0 -p 744 -st none -pt topic385_4_0 -u 0.027866592328302242 > ./result_10chains/node385_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_0 -p 751 -st none -pt topic385_5_0 -u 0.01242245188076943 > ./result_10chains/node385_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_6_0 -p 782 -st none -pt topic385_6_0 -u 0.03150507817945286 > ./result_10chains/node385_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_7_0 -p 910 -st none -pt topic385_7_0 -u 0.011982259676343615 > ./result_10chains/node385_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_8_0 -p 974 -st none -pt topic385_8_0 -u 0.007036135846441506 > ./result_10chains/node385_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_9_0 -p 999 -st none -pt topic385_9_0 -u 0.0033600668215124987 > ./result_10chains/node385_9_0.txt &
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
    "./result_10chains/node385_0_0.txt 90"
    "./result_10chains/node385_0_2.txt 90"
    "./result_10chains/node385_1_0.txt 89"
    "./result_10chains/node385_1_2.txt 89"
    "./result_10chains/node385_2_0.txt 88"
    "./result_10chains/node385_2_2.txt 88"
    "./result_10chains/node385_3_0.txt 87"
    "./result_10chains/node385_3_2.txt 87"
    "./result_10chains/node385_4_0.txt 86"
    "./result_10chains/node385_4_2.txt 86"
    "./result_10chains/node385_5_0.txt 85"
    "./result_10chains/node385_5_2.txt 85"
    "./result_10chains/node385_6_0.txt 84"
    "./result_10chains/node385_6_2.txt 84"
    "./result_10chains/node385_7_0.txt 83"
    "./result_10chains/node385_7_2.txt 83"
    "./result_10chains/node385_8_0.txt 82"
    "./result_10chains/node385_8_2.txt 82"
    "./result_10chains/node385_9_0.txt 81"
    "./result_10chains/node385_9_2.txt 81"
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
