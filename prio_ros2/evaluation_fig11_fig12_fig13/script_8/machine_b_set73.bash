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
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_1 -p 152 -st topic73_0_0 -pt topic73_0_1 -u 0.016672486853058832 > ./result_8chains/node73_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_1 -p 181 -st topic73_1_0 -pt topic73_1_1 -u 0.024056306860487042 > ./result_8chains/node73_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_1 -p 223 -st topic73_2_0 -pt topic73_2_1 -u 0.05785290543183422 > ./result_8chains/node73_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_1 -p 536 -st topic73_3_0 -pt topic73_3_1 -u 0.0064976701770502465 > ./result_8chains/node73_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_1 -p 826 -st topic73_4_0 -pt topic73_4_1 -u 0.0009951285107577257 > ./result_8chains/node73_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_1 -p 850 -st topic73_5_0 -pt topic73_5_1 -u 0.0012836544275756506 > ./result_8chains/node73_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_6_1 -p 885 -st topic73_6_0 -pt topic73_6_1 -u 0.001550300365156923 > ./result_8chains/node73_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_7_1 -p 972 -st topic73_7_0 -pt topic73_7_1 -u 0.011632003935768673 > ./result_8chains/node73_7_1.txt &
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
    "./result_8chains/node73_0_1.txt 90"
    "./result_8chains/node73_1_1.txt 89"
    "./result_8chains/node73_2_1.txt 88"
    "./result_8chains/node73_3_1.txt 87"
    "./result_8chains/node73_4_1.txt 86"
    "./result_8chains/node73_5_1.txt 85"
    "./result_8chains/node73_6_1.txt 84"
    "./result_8chains/node73_7_1.txt 83"
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
