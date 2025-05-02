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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_2 -p 115 -st topic357_0_1 -pt None -u 0.02182387757338844 > ./result_6chains/node357_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_2 -p 136 -st topic357_1_1 -pt None -u 0.009500749413049459 > ./result_6chains/node357_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_2 -p 154 -st topic357_2_1 -pt None -u 0.035866441343466504 > ./result_6chains/node357_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_2 -p 367 -st topic357_3_1 -pt None -u 0.06123156568409774 > ./result_6chains/node357_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_2 -p 600 -st topic357_4_1 -pt None -u 0.0034819920827778156 > ./result_6chains/node357_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_2 -p 716 -st topic357_5_1 -pt None -u 0.0013706644475246304 > ./result_6chains/node357_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_0 -p 115 -st none -pt topic357_0_0 -u 0.020543915286793668 > ./result_6chains/node357_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_0 -p 136 -st none -pt topic357_1_0 -u 0.0260529068865743 > ./result_6chains/node357_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_0 -p 154 -st none -pt topic357_2_0 -u 0.030865474906204726 > ./result_6chains/node357_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_0 -p 367 -st none -pt topic357_3_0 -u 0.0018662047497512435 > ./result_6chains/node357_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_0 -p 600 -st none -pt topic357_4_0 -u 0.04919446880221759 > ./result_6chains/node357_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_0 -p 716 -st none -pt topic357_5_0 -u 0.01500390571783295 > ./result_6chains/node357_5_0.txt &
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
    "./result_6chains/node357_0_0.txt 90"
    "./result_6chains/node357_0_2.txt 90"
    "./result_6chains/node357_1_0.txt 89"
    "./result_6chains/node357_1_2.txt 89"
    "./result_6chains/node357_2_0.txt 88"
    "./result_6chains/node357_2_2.txt 88"
    "./result_6chains/node357_3_0.txt 87"
    "./result_6chains/node357_3_2.txt 87"
    "./result_6chains/node357_4_0.txt 86"
    "./result_6chains/node357_4_2.txt 86"
    "./result_6chains/node357_5_0.txt 85"
    "./result_6chains/node357_5_2.txt 85"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
