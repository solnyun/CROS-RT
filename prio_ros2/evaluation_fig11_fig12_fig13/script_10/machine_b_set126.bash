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
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_1 -p 54 -st topic126_0_0 -pt topic126_0_1 -u 0.01164462505980507 > ./result_10chains/node126_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_1 -p 141 -st topic126_1_0 -pt topic126_1_1 -u 0.009770851188945329 > ./result_10chains/node126_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_1 -p 239 -st topic126_2_0 -pt topic126_2_1 -u 0.05614261274441329 > ./result_10chains/node126_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_1 -p 613 -st topic126_3_0 -pt topic126_3_1 -u 0.005593337098794338 > ./result_10chains/node126_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_1 -p 615 -st topic126_4_0 -pt topic126_4_1 -u 0.044220590470693905 > ./result_10chains/node126_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_1 -p 646 -st topic126_5_0 -pt topic126_5_1 -u 0.00667021027129211 > ./result_10chains/node126_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_1 -p 662 -st topic126_6_0 -pt topic126_6_1 -u 0.009904248744118493 > ./result_10chains/node126_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_1 -p 832 -st topic126_7_0 -pt topic126_7_1 -u 0.07637590212020706 > ./result_10chains/node126_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_8_1 -p 933 -st topic126_8_0 -pt topic126_8_1 -u 0.0006939981563894825 > ./result_10chains/node126_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_9_1 -p 943 -st topic126_9_0 -pt topic126_9_1 -u 0.004834495956106727 > ./result_10chains/node126_9_1.txt &
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
    "./result_10chains/node126_0_1.txt 90"
    "./result_10chains/node126_1_1.txt 89"
    "./result_10chains/node126_2_1.txt 88"
    "./result_10chains/node126_3_1.txt 87"
    "./result_10chains/node126_4_1.txt 86"
    "./result_10chains/node126_5_1.txt 85"
    "./result_10chains/node126_6_1.txt 84"
    "./result_10chains/node126_7_1.txt 83"
    "./result_10chains/node126_8_1.txt 82"
    "./result_10chains/node126_9_1.txt 81"
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
