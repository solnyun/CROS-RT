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
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_1 -p 29 -st topic97_0_0 -pt topic97_0_1 -u 0.00759125597236443 > ./result_10chains/node97_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_1 -p 174 -st topic97_1_0 -pt topic97_1_1 -u 0.04887175911500252 > ./result_10chains/node97_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_1 -p 231 -st topic97_2_0 -pt topic97_2_1 -u 0.013979085943143343 > ./result_10chains/node97_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_1 -p 232 -st topic97_3_0 -pt topic97_3_1 -u 0.01831894045232413 > ./result_10chains/node97_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_1 -p 330 -st topic97_4_0 -pt topic97_4_1 -u 0.0012948618085098507 > ./result_10chains/node97_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_1 -p 405 -st topic97_5_0 -pt topic97_5_1 -u 0.010496814880469274 > ./result_10chains/node97_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_6_1 -p 496 -st topic97_6_0 -pt topic97_6_1 -u 0.04129241561733335 > ./result_10chains/node97_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_7_1 -p 559 -st topic97_7_0 -pt topic97_7_1 -u 0.0001755136053573636 > ./result_10chains/node97_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_8_1 -p 594 -st topic97_8_0 -pt topic97_8_1 -u 0.018220165263400215 > ./result_10chains/node97_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_9_1 -p 733 -st topic97_9_0 -pt topic97_9_1 -u 0.014150327040523658 > ./result_10chains/node97_9_1.txt &
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
    "./result_10chains/node97_0_1.txt 90"
    "./result_10chains/node97_1_1.txt 89"
    "./result_10chains/node97_2_1.txt 88"
    "./result_10chains/node97_3_1.txt 87"
    "./result_10chains/node97_4_1.txt 86"
    "./result_10chains/node97_5_1.txt 85"
    "./result_10chains/node97_6_1.txt 84"
    "./result_10chains/node97_7_1.txt 83"
    "./result_10chains/node97_8_1.txt 82"
    "./result_10chains/node97_9_1.txt 81"
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
