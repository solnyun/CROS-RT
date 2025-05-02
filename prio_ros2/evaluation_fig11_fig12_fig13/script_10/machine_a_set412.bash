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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_2 -p 150 -st topic412_0_1 -pt None -u 0.01776719514876518 > ./result_10chains/node412_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_2 -p 177 -st topic412_1_1 -pt None -u 0.013938841802061341 > ./result_10chains/node412_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_2 -p 261 -st topic412_2_1 -pt None -u 0.005065056444006011 > ./result_10chains/node412_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_2 -p 276 -st topic412_3_1 -pt None -u 0.04728053142643174 > ./result_10chains/node412_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_2 -p 594 -st topic412_4_1 -pt None -u 0.0022114012706350716 > ./result_10chains/node412_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_2 -p 731 -st topic412_5_1 -pt None -u 0.01568704246885097 > ./result_10chains/node412_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_2 -p 838 -st topic412_6_1 -pt None -u 0.003661586333654515 > ./result_10chains/node412_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_2 -p 850 -st topic412_7_1 -pt None -u 0.017622275790268233 > ./result_10chains/node412_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_8_2 -p 915 -st topic412_8_1 -pt None -u 0.00875822808568559 > ./result_10chains/node412_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_9_2 -p 932 -st topic412_9_1 -pt None -u 0.0027420090800999793 > ./result_10chains/node412_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_0 -p 150 -st none -pt topic412_0_0 -u 0.009909401366417714 > ./result_10chains/node412_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_0 -p 177 -st none -pt topic412_1_0 -u 0.011565527563723865 > ./result_10chains/node412_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_0 -p 261 -st none -pt topic412_2_0 -u 0.012278202495375978 > ./result_10chains/node412_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_0 -p 276 -st none -pt topic412_3_0 -u 0.028283220243192353 > ./result_10chains/node412_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_0 -p 594 -st none -pt topic412_4_0 -u 0.0023056998075188795 > ./result_10chains/node412_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_0 -p 731 -st none -pt topic412_5_0 -u 0.0067728596929864104 > ./result_10chains/node412_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_0 -p 838 -st none -pt topic412_6_0 -u 0.038644528658852095 > ./result_10chains/node412_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_0 -p 850 -st none -pt topic412_7_0 -u 0.016208111438002215 > ./result_10chains/node412_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_8_0 -p 915 -st none -pt topic412_8_0 -u 0.01853283181170052 > ./result_10chains/node412_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_9_0 -p 932 -st none -pt topic412_9_0 -u 0.018616677172557987 > ./result_10chains/node412_9_0.txt &
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
    "./result_10chains/node412_0_0.txt 90"
    "./result_10chains/node412_0_2.txt 90"
    "./result_10chains/node412_1_0.txt 89"
    "./result_10chains/node412_1_2.txt 89"
    "./result_10chains/node412_2_0.txt 88"
    "./result_10chains/node412_2_2.txt 88"
    "./result_10chains/node412_3_0.txt 87"
    "./result_10chains/node412_3_2.txt 87"
    "./result_10chains/node412_4_0.txt 86"
    "./result_10chains/node412_4_2.txt 86"
    "./result_10chains/node412_5_0.txt 85"
    "./result_10chains/node412_5_2.txt 85"
    "./result_10chains/node412_6_0.txt 84"
    "./result_10chains/node412_6_2.txt 84"
    "./result_10chains/node412_7_0.txt 83"
    "./result_10chains/node412_7_2.txt 83"
    "./result_10chains/node412_8_0.txt 82"
    "./result_10chains/node412_8_2.txt 82"
    "./result_10chains/node412_9_0.txt 81"
    "./result_10chains/node412_9_2.txt 81"
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
