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
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_1 -p 152 -st topic400_0_0 -pt topic400_0_1 -u 0.0134086411117873 > ./result_10chains/node400_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_1 -p 179 -st topic400_1_0 -pt topic400_1_1 -u 0.027433519972419274 > ./result_10chains/node400_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_1 -p 192 -st topic400_2_0 -pt topic400_2_1 -u 0.029240798948757807 > ./result_10chains/node400_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_1 -p 319 -st topic400_3_0 -pt topic400_3_1 -u 0.0011276421591300823 > ./result_10chains/node400_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_1 -p 338 -st topic400_4_0 -pt topic400_4_1 -u 0.001129624938855489 > ./result_10chains/node400_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_1 -p 434 -st topic400_5_0 -pt topic400_5_1 -u 0.04400790983808428 > ./result_10chains/node400_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_6_1 -p 490 -st topic400_6_0 -pt topic400_6_1 -u 0.020958213324533015 > ./result_10chains/node400_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_7_1 -p 497 -st topic400_7_0 -pt topic400_7_1 -u 0.012340738247283989 > ./result_10chains/node400_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_8_1 -p 629 -st topic400_8_0 -pt topic400_8_1 -u 0.03154307368126587 > ./result_10chains/node400_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_9_1 -p 661 -st topic400_9_0 -pt topic400_9_1 -u 0.0027599266022362047 > ./result_10chains/node400_9_1.txt &
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
    "./result_10chains/node400_0_1.txt 90"
    "./result_10chains/node400_1_1.txt 89"
    "./result_10chains/node400_2_1.txt 88"
    "./result_10chains/node400_3_1.txt 87"
    "./result_10chains/node400_4_1.txt 86"
    "./result_10chains/node400_5_1.txt 85"
    "./result_10chains/node400_6_1.txt 84"
    "./result_10chains/node400_7_1.txt 83"
    "./result_10chains/node400_8_1.txt 82"
    "./result_10chains/node400_9_1.txt 81"
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
