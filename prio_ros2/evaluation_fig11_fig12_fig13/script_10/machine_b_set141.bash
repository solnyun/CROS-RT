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
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_1 -p 94 -st topic141_0_0 -pt topic141_0_1 -u 0.004542334834198691 > ./result_10chains/node141_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_1 -p 132 -st topic141_1_0 -pt topic141_1_1 -u 0.014900203511783894 > ./result_10chains/node141_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_1 -p 181 -st topic141_2_0 -pt topic141_2_1 -u 0.0028677844894858806 > ./result_10chains/node141_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_1 -p 364 -st topic141_3_0 -pt topic141_3_1 -u 0.035866591478826454 > ./result_10chains/node141_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_1 -p 395 -st topic141_4_0 -pt topic141_4_1 -u 5.019219883864445e-05 > ./result_10chains/node141_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_1 -p 661 -st topic141_5_0 -pt topic141_5_1 -u 0.004707668860650049 > ./result_10chains/node141_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_1 -p 705 -st topic141_6_0 -pt topic141_6_1 -u 0.003077507733234869 > ./result_10chains/node141_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_1 -p 792 -st topic141_7_0 -pt topic141_7_1 -u 0.00962620036804182 > ./result_10chains/node141_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_8_1 -p 867 -st topic141_8_0 -pt topic141_8_1 -u 0.0021390721564257115 > ./result_10chains/node141_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_9_1 -p 997 -st topic141_9_0 -pt topic141_9_1 -u 0.0010632527741778605 > ./result_10chains/node141_9_1.txt &
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
    "./result_10chains/node141_0_1.txt 90"
    "./result_10chains/node141_1_1.txt 89"
    "./result_10chains/node141_2_1.txt 88"
    "./result_10chains/node141_3_1.txt 87"
    "./result_10chains/node141_4_1.txt 86"
    "./result_10chains/node141_5_1.txt 85"
    "./result_10chains/node141_6_1.txt 84"
    "./result_10chains/node141_7_1.txt 83"
    "./result_10chains/node141_8_1.txt 82"
    "./result_10chains/node141_9_1.txt 81"
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
