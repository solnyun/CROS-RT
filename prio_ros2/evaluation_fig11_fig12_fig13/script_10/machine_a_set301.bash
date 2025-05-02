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
ros2 run evaluation_3_randomdag uunifast_node -n node301_0_2 -p 15 -st topic301_0_1 -pt None -u 0.004477014223409348 > ./result_10chains/node301_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_1_2 -p 94 -st topic301_1_1 -pt None -u 0.0007672458891903045 > ./result_10chains/node301_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_2_2 -p 133 -st topic301_2_1 -pt None -u 0.006996900668030437 > ./result_10chains/node301_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_3_2 -p 502 -st topic301_3_1 -pt None -u 0.003758867588313619 > ./result_10chains/node301_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_4_2 -p 547 -st topic301_4_1 -pt None -u 0.012138260517285782 > ./result_10chains/node301_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_5_2 -p 569 -st topic301_5_1 -pt None -u 0.025470365492907016 > ./result_10chains/node301_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_6_2 -p 682 -st topic301_6_1 -pt None -u 0.02540605221650155 > ./result_10chains/node301_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_7_2 -p 756 -st topic301_7_1 -pt None -u 0.03968822326892121 > ./result_10chains/node301_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_8_2 -p 942 -st topic301_8_1 -pt None -u 0.015903287803138294 > ./result_10chains/node301_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_9_2 -p 959 -st topic301_9_1 -pt None -u 0.011919081395658379 > ./result_10chains/node301_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_0_0 -p 15 -st none -pt topic301_0_0 -u 0.009326664586824351 > ./result_10chains/node301_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_1_0 -p 94 -st none -pt topic301_1_0 -u 0.07060168541585848 > ./result_10chains/node301_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_2_0 -p 133 -st none -pt topic301_2_0 -u 0.011530906093450921 > ./result_10chains/node301_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_3_0 -p 502 -st none -pt topic301_3_0 -u 0.03623604696694949 > ./result_10chains/node301_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_4_0 -p 547 -st none -pt topic301_4_0 -u 0.0056757070515856545 > ./result_10chains/node301_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_5_0 -p 569 -st none -pt topic301_5_0 -u 0.0010485197206897834 > ./result_10chains/node301_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_6_0 -p 682 -st none -pt topic301_6_0 -u 0.0007034755063562714 > ./result_10chains/node301_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_7_0 -p 756 -st none -pt topic301_7_0 -u 0.0005533389840501612 > ./result_10chains/node301_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_8_0 -p 942 -st none -pt topic301_8_0 -u 0.006652130944869147 > ./result_10chains/node301_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_9_0 -p 959 -st none -pt topic301_9_0 -u 0.05688410732488464 > ./result_10chains/node301_9_0.txt &
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
    "./result_10chains/node301_0_0.txt 90"
    "./result_10chains/node301_0_2.txt 90"
    "./result_10chains/node301_1_0.txt 89"
    "./result_10chains/node301_1_2.txt 89"
    "./result_10chains/node301_2_0.txt 88"
    "./result_10chains/node301_2_2.txt 88"
    "./result_10chains/node301_3_0.txt 87"
    "./result_10chains/node301_3_2.txt 87"
    "./result_10chains/node301_4_0.txt 86"
    "./result_10chains/node301_4_2.txt 86"
    "./result_10chains/node301_5_0.txt 85"
    "./result_10chains/node301_5_2.txt 85"
    "./result_10chains/node301_6_0.txt 84"
    "./result_10chains/node301_6_2.txt 84"
    "./result_10chains/node301_7_0.txt 83"
    "./result_10chains/node301_7_2.txt 83"
    "./result_10chains/node301_8_0.txt 82"
    "./result_10chains/node301_8_2.txt 82"
    "./result_10chains/node301_9_0.txt 81"
    "./result_10chains/node301_9_2.txt 81"
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
