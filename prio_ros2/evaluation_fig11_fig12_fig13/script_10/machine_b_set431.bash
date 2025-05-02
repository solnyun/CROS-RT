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
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_1 -p 83 -st topic431_0_0 -pt topic431_0_1 -u 0.0020086475802190695 > ./result_10chains/node431_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_1 -p 311 -st topic431_1_0 -pt topic431_1_1 -u 0.03948978024675032 > ./result_10chains/node431_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_1 -p 368 -st topic431_2_0 -pt topic431_2_1 -u 0.008290744801425998 > ./result_10chains/node431_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_1 -p 512 -st topic431_3_0 -pt topic431_3_1 -u 0.011575784100558206 > ./result_10chains/node431_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_1 -p 517 -st topic431_4_0 -pt topic431_4_1 -u 0.04450603973581002 > ./result_10chains/node431_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_1 -p 569 -st topic431_5_0 -pt topic431_5_1 -u 0.0051988211816367536 > ./result_10chains/node431_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_6_1 -p 601 -st topic431_6_0 -pt topic431_6_1 -u 0.0591147534984426 > ./result_10chains/node431_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_7_1 -p 612 -st topic431_7_0 -pt topic431_7_1 -u 0.036376306250071114 > ./result_10chains/node431_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_8_1 -p 674 -st topic431_8_0 -pt topic431_8_1 -u 0.0005813334692522792 > ./result_10chains/node431_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_9_1 -p 891 -st topic431_9_0 -pt topic431_9_1 -u 0.008647893366036247 > ./result_10chains/node431_9_1.txt &
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
    "./result_10chains/node431_0_1.txt 90"
    "./result_10chains/node431_1_1.txt 89"
    "./result_10chains/node431_2_1.txt 88"
    "./result_10chains/node431_3_1.txt 87"
    "./result_10chains/node431_4_1.txt 86"
    "./result_10chains/node431_5_1.txt 85"
    "./result_10chains/node431_6_1.txt 84"
    "./result_10chains/node431_7_1.txt 83"
    "./result_10chains/node431_8_1.txt 82"
    "./result_10chains/node431_9_1.txt 81"
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
