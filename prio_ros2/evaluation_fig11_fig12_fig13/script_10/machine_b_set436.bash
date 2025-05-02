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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_1 -p 92 -st topic436_0_0 -pt topic436_0_1 -u 0.038143231133083155 > ./result_10chains/node436_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_1 -p 256 -st topic436_1_0 -pt topic436_1_1 -u 0.027563732601378788 > ./result_10chains/node436_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_1 -p 395 -st topic436_2_0 -pt topic436_2_1 -u 0.06744026024160732 > ./result_10chains/node436_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_1 -p 400 -st topic436_3_0 -pt topic436_3_1 -u 0.006797795586528044 > ./result_10chains/node436_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_1 -p 421 -st topic436_4_0 -pt topic436_4_1 -u 0.003952245844969449 > ./result_10chains/node436_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_1 -p 483 -st topic436_5_0 -pt topic436_5_1 -u 0.006106333184676627 > ./result_10chains/node436_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_1 -p 647 -st topic436_6_0 -pt topic436_6_1 -u 0.02303928574597508 > ./result_10chains/node436_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_1 -p 666 -st topic436_7_0 -pt topic436_7_1 -u 0.001439020280626896 > ./result_10chains/node436_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_8_1 -p 765 -st topic436_8_0 -pt topic436_8_1 -u 0.001010545035800961 > ./result_10chains/node436_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_9_1 -p 944 -st topic436_9_0 -pt topic436_9_1 -u 0.02111950346678194 > ./result_10chains/node436_9_1.txt &
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
    "./result_10chains/node436_0_1.txt 90"
    "./result_10chains/node436_1_1.txt 89"
    "./result_10chains/node436_2_1.txt 88"
    "./result_10chains/node436_3_1.txt 87"
    "./result_10chains/node436_4_1.txt 86"
    "./result_10chains/node436_5_1.txt 85"
    "./result_10chains/node436_6_1.txt 84"
    "./result_10chains/node436_7_1.txt 83"
    "./result_10chains/node436_8_1.txt 82"
    "./result_10chains/node436_9_1.txt 81"
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
