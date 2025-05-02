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
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_1 -p 133 -st topic72_0_0 -pt topic72_0_1 -u 0.03047909179577235 > ./result_8chains/node72_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_1 -p 157 -st topic72_1_0 -pt topic72_1_1 -u 0.010959425637786735 > ./result_8chains/node72_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_1 -p 232 -st topic72_2_0 -pt topic72_2_1 -u 0.005251417595814711 > ./result_8chains/node72_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_1 -p 591 -st topic72_3_0 -pt topic72_3_1 -u 0.025634165485953986 > ./result_8chains/node72_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_1 -p 645 -st topic72_4_0 -pt topic72_4_1 -u 0.06728720425074039 > ./result_8chains/node72_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_1 -p 787 -st topic72_5_0 -pt topic72_5_1 -u 0.003934331205591918 > ./result_8chains/node72_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_1 -p 911 -st topic72_6_0 -pt topic72_6_1 -u 0.015593013335567105 > ./result_8chains/node72_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_1 -p 987 -st topic72_7_0 -pt topic72_7_1 -u 0.03121140188621785 > ./result_8chains/node72_7_1.txt &
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
    "./result_8chains/node72_0_1.txt 90"
    "./result_8chains/node72_1_1.txt 89"
    "./result_8chains/node72_2_1.txt 88"
    "./result_8chains/node72_3_1.txt 87"
    "./result_8chains/node72_4_1.txt 86"
    "./result_8chains/node72_5_1.txt 85"
    "./result_8chains/node72_6_1.txt 84"
    "./result_8chains/node72_7_1.txt 83"
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
