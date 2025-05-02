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
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_1 -p 96 -st topic268_0_0 -pt topic268_0_1 -u 0.0021390628160797287 > ./result_10chains/node268_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_1 -p 100 -st topic268_1_0 -pt topic268_1_1 -u 0.0005859147718628721 > ./result_10chains/node268_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_1 -p 401 -st topic268_2_0 -pt topic268_2_1 -u 0.009988274493700489 > ./result_10chains/node268_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_1 -p 590 -st topic268_3_0 -pt topic268_3_1 -u 0.0020759136484769236 > ./result_10chains/node268_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_1 -p 611 -st topic268_4_0 -pt topic268_4_1 -u 0.006985220322169361 > ./result_10chains/node268_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_1 -p 685 -st topic268_5_0 -pt topic268_5_1 -u 0.013347246818792458 > ./result_10chains/node268_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_6_1 -p 748 -st topic268_6_0 -pt topic268_6_1 -u 0.03163687943449239 > ./result_10chains/node268_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_7_1 -p 886 -st topic268_7_0 -pt topic268_7_1 -u 0.03261178931499442 > ./result_10chains/node268_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_8_1 -p 902 -st topic268_8_0 -pt topic268_8_1 -u 0.010653576485585042 > ./result_10chains/node268_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_9_1 -p 963 -st topic268_9_0 -pt topic268_9_1 -u 0.008545841968386664 > ./result_10chains/node268_9_1.txt &
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
    "./result_10chains/node268_0_1.txt 90"
    "./result_10chains/node268_1_1.txt 89"
    "./result_10chains/node268_2_1.txt 88"
    "./result_10chains/node268_3_1.txt 87"
    "./result_10chains/node268_4_1.txt 86"
    "./result_10chains/node268_5_1.txt 85"
    "./result_10chains/node268_6_1.txt 84"
    "./result_10chains/node268_7_1.txt 83"
    "./result_10chains/node268_8_1.txt 82"
    "./result_10chains/node268_9_1.txt 81"
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
