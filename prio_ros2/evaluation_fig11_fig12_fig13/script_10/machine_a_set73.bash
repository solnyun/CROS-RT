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
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_2 -p 211 -st topic73_0_1 -pt None -u 0.003598798773574552 > ./result_10chains/node73_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_2 -p 239 -st topic73_1_1 -pt None -u 0.0012272834390492093 > ./result_10chains/node73_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_2 -p 303 -st topic73_2_1 -pt None -u 0.012855339648354669 > ./result_10chains/node73_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_2 -p 304 -st topic73_3_1 -pt None -u 0.04045344183985683 > ./result_10chains/node73_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_2 -p 328 -st topic73_4_1 -pt None -u 0.0035058195257227087 > ./result_10chains/node73_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_2 -p 380 -st topic73_5_1 -pt None -u 0.03689010892980779 > ./result_10chains/node73_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_6_2 -p 517 -st topic73_6_1 -pt None -u 0.020419927501413387 > ./result_10chains/node73_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_7_2 -p 814 -st topic73_7_1 -pt None -u 0.028857585050370047 > ./result_10chains/node73_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_8_2 -p 880 -st topic73_8_1 -pt None -u 0.041758675235862866 > ./result_10chains/node73_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_9_2 -p 933 -st topic73_9_1 -pt None -u 0.014556287065771762 > ./result_10chains/node73_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_0 -p 211 -st none -pt topic73_0_0 -u 0.003141021735943217 > ./result_10chains/node73_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_0 -p 239 -st none -pt topic73_1_0 -u 0.011602527780221916 > ./result_10chains/node73_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_0 -p 303 -st none -pt topic73_2_0 -u 0.012165288666412755 > ./result_10chains/node73_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_0 -p 304 -st none -pt topic73_3_0 -u 0.004178812237806917 > ./result_10chains/node73_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_0 -p 328 -st none -pt topic73_4_0 -u 0.01715253434938646 > ./result_10chains/node73_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_0 -p 380 -st none -pt topic73_5_0 -u 0.0233165787854831 > ./result_10chains/node73_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_6_0 -p 517 -st none -pt topic73_6_0 -u 0.004292265126455447 > ./result_10chains/node73_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_7_0 -p 814 -st none -pt topic73_7_0 -u 0.011204083827492967 > ./result_10chains/node73_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_8_0 -p 880 -st none -pt topic73_8_0 -u 0.015994608622820775 > ./result_10chains/node73_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_9_0 -p 933 -st none -pt topic73_9_0 -u 0.004920929449766721 > ./result_10chains/node73_9_0.txt &
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
    "./result_10chains/node73_0_0.txt 90"
    "./result_10chains/node73_0_2.txt 90"
    "./result_10chains/node73_1_0.txt 89"
    "./result_10chains/node73_1_2.txt 89"
    "./result_10chains/node73_2_0.txt 88"
    "./result_10chains/node73_2_2.txt 88"
    "./result_10chains/node73_3_0.txt 87"
    "./result_10chains/node73_3_2.txt 87"
    "./result_10chains/node73_4_0.txt 86"
    "./result_10chains/node73_4_2.txt 86"
    "./result_10chains/node73_5_0.txt 85"
    "./result_10chains/node73_5_2.txt 85"
    "./result_10chains/node73_6_0.txt 84"
    "./result_10chains/node73_6_2.txt 84"
    "./result_10chains/node73_7_0.txt 83"
    "./result_10chains/node73_7_2.txt 83"
    "./result_10chains/node73_8_0.txt 82"
    "./result_10chains/node73_8_2.txt 82"
    "./result_10chains/node73_9_0.txt 81"
    "./result_10chains/node73_9_2.txt 81"
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
