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
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_1 -p 94 -st topic296_0_0 -pt topic296_0_1 -u 0.0009004293191263724 > ./result_8chains/node296_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_1 -p 129 -st topic296_1_0 -pt topic296_1_1 -u 0.011603921196649103 > ./result_8chains/node296_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_1 -p 218 -st topic296_2_0 -pt topic296_2_1 -u 0.041232501932748244 > ./result_8chains/node296_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_1 -p 264 -st topic296_3_0 -pt topic296_3_1 -u 0.0031295811478391777 > ./result_8chains/node296_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_1 -p 265 -st topic296_4_0 -pt topic296_4_1 -u 0.0008526603878660777 > ./result_8chains/node296_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_1 -p 369 -st topic296_5_0 -pt topic296_5_1 -u 0.0035680655086817725 > ./result_8chains/node296_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_1 -p 598 -st topic296_6_0 -pt topic296_6_1 -u 0.05486208456027382 > ./result_8chains/node296_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_1 -p 839 -st topic296_7_0 -pt topic296_7_1 -u 0.028540286797372368 > ./result_8chains/node296_7_1.txt &
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
    "./result_8chains/node296_0_1.txt 90"
    "./result_8chains/node296_1_1.txt 89"
    "./result_8chains/node296_2_1.txt 88"
    "./result_8chains/node296_3_1.txt 87"
    "./result_8chains/node296_4_1.txt 86"
    "./result_8chains/node296_5_1.txt 85"
    "./result_8chains/node296_6_1.txt 84"
    "./result_8chains/node296_7_1.txt 83"
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
