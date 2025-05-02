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
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_1 -p 19 -st topic95_0_0 -pt topic95_0_1 -u 0.017509072067499853 > ./result_10chains/node95_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_1 -p 147 -st topic95_1_0 -pt topic95_1_1 -u 0.0007054160069597804 > ./result_10chains/node95_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_1 -p 271 -st topic95_2_0 -pt topic95_2_1 -u 0.004278822708212282 > ./result_10chains/node95_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_1 -p 367 -st topic95_3_0 -pt topic95_3_1 -u 0.04119824228652191 > ./result_10chains/node95_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_1 -p 621 -st topic95_4_0 -pt topic95_4_1 -u 0.06925465509630249 > ./result_10chains/node95_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_1 -p 714 -st topic95_5_0 -pt topic95_5_1 -u 0.002002239915104065 > ./result_10chains/node95_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_1 -p 742 -st topic95_6_0 -pt topic95_6_1 -u 0.0032848244999245935 > ./result_10chains/node95_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_1 -p 772 -st topic95_7_0 -pt topic95_7_1 -u 0.00453061493510501 > ./result_10chains/node95_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_8_1 -p 849 -st topic95_8_0 -pt topic95_8_1 -u 0.057959782916915004 > ./result_10chains/node95_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_9_1 -p 885 -st topic95_9_0 -pt topic95_9_1 -u 0.007663458456804205 > ./result_10chains/node95_9_1.txt &
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
    "./result_10chains/node95_0_1.txt 90"
    "./result_10chains/node95_1_1.txt 89"
    "./result_10chains/node95_2_1.txt 88"
    "./result_10chains/node95_3_1.txt 87"
    "./result_10chains/node95_4_1.txt 86"
    "./result_10chains/node95_5_1.txt 85"
    "./result_10chains/node95_6_1.txt 84"
    "./result_10chains/node95_7_1.txt 83"
    "./result_10chains/node95_8_1.txt 82"
    "./result_10chains/node95_9_1.txt 81"
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
