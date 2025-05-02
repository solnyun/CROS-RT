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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_2 -p 84 -st topic38_0_1 -pt None -u 0.005820854137960407 > ./result_6chains/node38_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_2 -p 281 -st topic38_1_1 -pt None -u 0.062350095508657 > ./result_6chains/node38_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_2 -p 406 -st topic38_2_1 -pt None -u 0.016751434791958647 > ./result_6chains/node38_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_2 -p 610 -st topic38_3_1 -pt None -u 0.015646593198697878 > ./result_6chains/node38_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_2 -p 728 -st topic38_4_1 -pt None -u 0.01442843585608132 > ./result_6chains/node38_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_2 -p 902 -st topic38_5_1 -pt None -u 0.05360419810812001 > ./result_6chains/node38_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_0 -p 84 -st none -pt topic38_0_0 -u 0.033250843545108266 > ./result_6chains/node38_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_0 -p 281 -st none -pt topic38_1_0 -u 0.061319961994546035 > ./result_6chains/node38_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_0 -p 406 -st none -pt topic38_2_0 -u 0.010818386428915028 > ./result_6chains/node38_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_0 -p 610 -st none -pt topic38_3_0 -u 0.008341288258740392 > ./result_6chains/node38_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_0 -p 728 -st none -pt topic38_4_0 -u 0.046671524625203756 > ./result_6chains/node38_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_0 -p 902 -st none -pt topic38_5_0 -u 0.0020732540870285338 > ./result_6chains/node38_5_0.txt &
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
    "./result_6chains/node38_0_0.txt 90"
    "./result_6chains/node38_0_2.txt 90"
    "./result_6chains/node38_1_0.txt 89"
    "./result_6chains/node38_1_2.txt 89"
    "./result_6chains/node38_2_0.txt 88"
    "./result_6chains/node38_2_2.txt 88"
    "./result_6chains/node38_3_0.txt 87"
    "./result_6chains/node38_3_2.txt 87"
    "./result_6chains/node38_4_0.txt 86"
    "./result_6chains/node38_4_2.txt 86"
    "./result_6chains/node38_5_0.txt 85"
    "./result_6chains/node38_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
