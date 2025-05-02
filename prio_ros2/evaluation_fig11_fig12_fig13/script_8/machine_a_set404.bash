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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_2 -p 402 -st topic404_0_1 -pt None -u 0.03210289296156432 > ./result_8chains/node404_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_2 -p 466 -st topic404_1_1 -pt None -u 0.029248472145933846 > ./result_8chains/node404_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_2 -p 480 -st topic404_2_1 -pt None -u 0.00895065561362074 > ./result_8chains/node404_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_2 -p 492 -st topic404_3_1 -pt None -u 0.009139594893102204 > ./result_8chains/node404_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_2 -p 620 -st topic404_4_1 -pt None -u 0.02129264895938443 > ./result_8chains/node404_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_2 -p 703 -st topic404_5_1 -pt None -u 0.01206768252900417 > ./result_8chains/node404_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_2 -p 979 -st topic404_6_1 -pt None -u 0.033958386513649366 > ./result_8chains/node404_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_2 -p 986 -st topic404_7_1 -pt None -u 0.0027134407025408156 > ./result_8chains/node404_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_0 -p 402 -st none -pt topic404_0_0 -u 0.0919044126456916 > ./result_8chains/node404_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_0 -p 466 -st none -pt topic404_1_0 -u 0.00741389194345049 > ./result_8chains/node404_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_0 -p 480 -st none -pt topic404_2_0 -u 0.036113867168532154 > ./result_8chains/node404_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_0 -p 492 -st none -pt topic404_3_0 -u 0.0010826769109272272 > ./result_8chains/node404_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_0 -p 620 -st none -pt topic404_4_0 -u 0.0012781602440657958 > ./result_8chains/node404_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_0 -p 703 -st none -pt topic404_5_0 -u 0.04176023019066498 > ./result_8chains/node404_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_0 -p 979 -st none -pt topic404_6_0 -u 0.02001443299270958 > ./result_8chains/node404_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_0 -p 986 -st none -pt topic404_7_0 -u 0.008698081734602849 > ./result_8chains/node404_7_0.txt &
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
    "./result_8chains/node404_0_0.txt 90"
    "./result_8chains/node404_0_2.txt 90"
    "./result_8chains/node404_1_0.txt 89"
    "./result_8chains/node404_1_2.txt 89"
    "./result_8chains/node404_2_0.txt 88"
    "./result_8chains/node404_2_2.txt 88"
    "./result_8chains/node404_3_0.txt 87"
    "./result_8chains/node404_3_2.txt 87"
    "./result_8chains/node404_4_0.txt 86"
    "./result_8chains/node404_4_2.txt 86"
    "./result_8chains/node404_5_0.txt 85"
    "./result_8chains/node404_5_2.txt 85"
    "./result_8chains/node404_6_0.txt 84"
    "./result_8chains/node404_6_2.txt 84"
    "./result_8chains/node404_7_0.txt 83"
    "./result_8chains/node404_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
