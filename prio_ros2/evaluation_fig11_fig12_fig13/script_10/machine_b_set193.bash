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
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_1 -p 360 -st topic193_0_0 -pt topic193_0_1 -u 0.012027818600098994 > ./result_10chains/node193_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_1 -p 408 -st topic193_1_0 -pt topic193_1_1 -u 0.029114784578846642 > ./result_10chains/node193_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_1 -p 490 -st topic193_2_0 -pt topic193_2_1 -u 0.007960853920064737 > ./result_10chains/node193_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_1 -p 562 -st topic193_3_0 -pt topic193_3_1 -u 0.0006201650131275049 > ./result_10chains/node193_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_1 -p 683 -st topic193_4_0 -pt topic193_4_1 -u 0.04316667713136432 > ./result_10chains/node193_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_1 -p 740 -st topic193_5_0 -pt topic193_5_1 -u 0.0027731050990394135 > ./result_10chains/node193_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_6_1 -p 779 -st topic193_6_0 -pt topic193_6_1 -u 0.0013793793112475417 > ./result_10chains/node193_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_7_1 -p 800 -st topic193_7_0 -pt topic193_7_1 -u 0.014575968253827065 > ./result_10chains/node193_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_8_1 -p 864 -st topic193_8_0 -pt topic193_8_1 -u 0.009365301180960288 > ./result_10chains/node193_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_9_1 -p 868 -st topic193_9_0 -pt topic193_9_1 -u 0.018565801505622495 > ./result_10chains/node193_9_1.txt &
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
    "./result_10chains/node193_0_1.txt 90"
    "./result_10chains/node193_1_1.txt 89"
    "./result_10chains/node193_2_1.txt 88"
    "./result_10chains/node193_3_1.txt 87"
    "./result_10chains/node193_4_1.txt 86"
    "./result_10chains/node193_5_1.txt 85"
    "./result_10chains/node193_6_1.txt 84"
    "./result_10chains/node193_7_1.txt 83"
    "./result_10chains/node193_8_1.txt 82"
    "./result_10chains/node193_9_1.txt 81"
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
