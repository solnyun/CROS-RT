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
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_2 -p 37 -st topic475_0_1 -pt None -u 0.01870608150732722 > ./result_10chains/node475_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_2 -p 114 -st topic475_1_1 -pt None -u 0.014197756897144642 > ./result_10chains/node475_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_2 -p 166 -st topic475_2_1 -pt None -u 8.58407272228412e-05 > ./result_10chains/node475_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_2 -p 194 -st topic475_3_1 -pt None -u 0.022636125630415393 > ./result_10chains/node475_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_2 -p 334 -st topic475_4_1 -pt None -u 0.026601774780040666 > ./result_10chains/node475_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_2 -p 473 -st topic475_5_1 -pt None -u 0.020701249201765554 > ./result_10chains/node475_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_2 -p 643 -st topic475_6_1 -pt None -u 0.04733224017129943 > ./result_10chains/node475_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_2 -p 840 -st topic475_7_1 -pt None -u 0.005128384402165967 > ./result_10chains/node475_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_8_2 -p 854 -st topic475_8_1 -pt None -u 0.011218455621595885 > ./result_10chains/node475_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_9_2 -p 884 -st topic475_9_1 -pt None -u 0.009934423798988744 > ./result_10chains/node475_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_0 -p 37 -st none -pt topic475_0_0 -u 0.011907932662303555 > ./result_10chains/node475_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_0 -p 114 -st none -pt topic475_1_0 -u 0.012596612899952397 > ./result_10chains/node475_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_0 -p 166 -st none -pt topic475_2_0 -u 0.005108117494878495 > ./result_10chains/node475_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_0 -p 194 -st none -pt topic475_3_0 -u 0.02673758369799306 > ./result_10chains/node475_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_0 -p 334 -st none -pt topic475_4_0 -u 0.009795645135244724 > ./result_10chains/node475_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_0 -p 473 -st none -pt topic475_5_0 -u 0.008735478534803609 > ./result_10chains/node475_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_0 -p 643 -st none -pt topic475_6_0 -u 0.06973523160789016 > ./result_10chains/node475_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_0 -p 840 -st none -pt topic475_7_0 -u 0.0016914968929978152 > ./result_10chains/node475_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_8_0 -p 854 -st none -pt topic475_8_0 -u 0.00034850134865291316 > ./result_10chains/node475_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_9_0 -p 884 -st none -pt topic475_9_0 -u 0.016071815663010337 > ./result_10chains/node475_9_0.txt &
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
    "./result_10chains/node475_0_0.txt 90"
    "./result_10chains/node475_0_2.txt 90"
    "./result_10chains/node475_1_0.txt 89"
    "./result_10chains/node475_1_2.txt 89"
    "./result_10chains/node475_2_0.txt 88"
    "./result_10chains/node475_2_2.txt 88"
    "./result_10chains/node475_3_0.txt 87"
    "./result_10chains/node475_3_2.txt 87"
    "./result_10chains/node475_4_0.txt 86"
    "./result_10chains/node475_4_2.txt 86"
    "./result_10chains/node475_5_0.txt 85"
    "./result_10chains/node475_5_2.txt 85"
    "./result_10chains/node475_6_0.txt 84"
    "./result_10chains/node475_6_2.txt 84"
    "./result_10chains/node475_7_0.txt 83"
    "./result_10chains/node475_7_2.txt 83"
    "./result_10chains/node475_8_0.txt 82"
    "./result_10chains/node475_8_2.txt 82"
    "./result_10chains/node475_9_0.txt 81"
    "./result_10chains/node475_9_2.txt 81"
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
