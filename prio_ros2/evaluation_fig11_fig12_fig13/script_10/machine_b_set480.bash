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
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_1 -p 23 -st topic480_0_0 -pt topic480_0_1 -u 0.034623628998931955 > ./result_10chains/node480_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_1 -p 35 -st topic480_1_0 -pt topic480_1_1 -u 0.02068935860583687 > ./result_10chains/node480_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_1 -p 57 -st topic480_2_0 -pt topic480_2_1 -u 0.005013829157758221 > ./result_10chains/node480_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_1 -p 222 -st topic480_3_0 -pt topic480_3_1 -u 0.005241534286177796 > ./result_10chains/node480_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_1 -p 357 -st topic480_4_0 -pt topic480_4_1 -u 0.07443909736248672 > ./result_10chains/node480_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_1 -p 380 -st topic480_5_0 -pt topic480_5_1 -u 0.0010907441441999621 > ./result_10chains/node480_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_1 -p 586 -st topic480_6_0 -pt topic480_6_1 -u 0.011267195840147709 > ./result_10chains/node480_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_1 -p 773 -st topic480_7_0 -pt topic480_7_1 -u 0.020058079616549956 > ./result_10chains/node480_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_8_1 -p 878 -st topic480_8_0 -pt topic480_8_1 -u 0.008756967647368538 > ./result_10chains/node480_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_9_1 -p 917 -st topic480_9_0 -pt topic480_9_1 -u 0.07765622457919887 > ./result_10chains/node480_9_1.txt &
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
    "./result_10chains/node480_0_1.txt 90"
    "./result_10chains/node480_1_1.txt 89"
    "./result_10chains/node480_2_1.txt 88"
    "./result_10chains/node480_3_1.txt 87"
    "./result_10chains/node480_4_1.txt 86"
    "./result_10chains/node480_5_1.txt 85"
    "./result_10chains/node480_6_1.txt 84"
    "./result_10chains/node480_7_1.txt 83"
    "./result_10chains/node480_8_1.txt 82"
    "./result_10chains/node480_9_1.txt 81"
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
