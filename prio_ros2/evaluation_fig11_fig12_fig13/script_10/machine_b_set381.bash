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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_1 -p 36 -st topic381_0_0 -pt topic381_0_1 -u 0.028425366625408233 > ./result_10chains/node381_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_1 -p 51 -st topic381_1_0 -pt topic381_1_1 -u 0.001298946273816437 > ./result_10chains/node381_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_1 -p 132 -st topic381_2_0 -pt topic381_2_1 -u 0.040794242727154206 > ./result_10chains/node381_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_1 -p 346 -st topic381_3_0 -pt topic381_3_1 -u 0.026104750875845573 > ./result_10chains/node381_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_1 -p 401 -st topic381_4_0 -pt topic381_4_1 -u 0.030460277849071182 > ./result_10chains/node381_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_1 -p 425 -st topic381_5_0 -pt topic381_5_1 -u 0.017694070947198492 > ./result_10chains/node381_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_1 -p 506 -st topic381_6_0 -pt topic381_6_1 -u 0.0405061055633778 > ./result_10chains/node381_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_1 -p 654 -st topic381_7_0 -pt topic381_7_1 -u 0.01380059048960909 > ./result_10chains/node381_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_8_1 -p 825 -st topic381_8_0 -pt topic381_8_1 -u 0.0016796567561175868 > ./result_10chains/node381_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_9_1 -p 881 -st topic381_9_0 -pt topic381_9_1 -u 0.045427943006957044 > ./result_10chains/node381_9_1.txt &
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
    "./result_10chains/node381_0_1.txt 90"
    "./result_10chains/node381_1_1.txt 89"
    "./result_10chains/node381_2_1.txt 88"
    "./result_10chains/node381_3_1.txt 87"
    "./result_10chains/node381_4_1.txt 86"
    "./result_10chains/node381_5_1.txt 85"
    "./result_10chains/node381_6_1.txt 84"
    "./result_10chains/node381_7_1.txt 83"
    "./result_10chains/node381_8_1.txt 82"
    "./result_10chains/node381_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
