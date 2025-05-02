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
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_1 -p 22 -st topic353_0_0 -pt topic353_0_1 -u 0.0005097471319742142 > ./result_10chains/node353_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_1 -p 68 -st topic353_1_0 -pt topic353_1_1 -u 0.016349997373423242 > ./result_10chains/node353_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_1 -p 146 -st topic353_2_0 -pt topic353_2_1 -u 0.06761175177065004 > ./result_10chains/node353_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_1 -p 147 -st topic353_3_0 -pt topic353_3_1 -u 0.005814934911183289 > ./result_10chains/node353_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_1 -p 328 -st topic353_4_0 -pt topic353_4_1 -u 0.0017569215548797479 > ./result_10chains/node353_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_1 -p 531 -st topic353_5_0 -pt topic353_5_1 -u 0.0030553010926011315 > ./result_10chains/node353_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_1 -p 569 -st topic353_6_0 -pt topic353_6_1 -u 0.017732753782311567 > ./result_10chains/node353_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_1 -p 711 -st topic353_7_0 -pt topic353_7_1 -u 0.008119628707675339 > ./result_10chains/node353_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_8_1 -p 776 -st topic353_8_0 -pt topic353_8_1 -u 0.00827201489541439 > ./result_10chains/node353_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_9_1 -p 921 -st topic353_9_0 -pt topic353_9_1 -u 0.024196705996568684 > ./result_10chains/node353_9_1.txt &
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
    "./result_10chains/node353_0_1.txt 90"
    "./result_10chains/node353_1_1.txt 89"
    "./result_10chains/node353_2_1.txt 88"
    "./result_10chains/node353_3_1.txt 87"
    "./result_10chains/node353_4_1.txt 86"
    "./result_10chains/node353_5_1.txt 85"
    "./result_10chains/node353_6_1.txt 84"
    "./result_10chains/node353_7_1.txt 83"
    "./result_10chains/node353_8_1.txt 82"
    "./result_10chains/node353_9_1.txt 81"
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
