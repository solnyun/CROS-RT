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
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_1 -p 197 -st topic478_0_0 -pt topic478_0_1 -u 0.0036153036573927655 > ./result_8chains/node478_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_1 -p 244 -st topic478_1_0 -pt topic478_1_1 -u 0.004306223089975525 > ./result_8chains/node478_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_1 -p 297 -st topic478_2_0 -pt topic478_2_1 -u 0.0037284332319860725 > ./result_8chains/node478_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_1 -p 409 -st topic478_3_0 -pt topic478_3_1 -u 0.011327268387448242 > ./result_8chains/node478_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_1 -p 603 -st topic478_4_0 -pt topic478_4_1 -u 0.08433798474520288 > ./result_8chains/node478_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_1 -p 721 -st topic478_5_0 -pt topic478_5_1 -u 0.10261100861736558 > ./result_8chains/node478_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_6_1 -p 803 -st topic478_6_0 -pt topic478_6_1 -u 0.020507656186414425 > ./result_8chains/node478_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_7_1 -p 961 -st topic478_7_0 -pt topic478_7_1 -u 0.01095275014832724 > ./result_8chains/node478_7_1.txt &
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
    "./result_8chains/node478_0_1.txt 90"
    "./result_8chains/node478_1_1.txt 89"
    "./result_8chains/node478_2_1.txt 88"
    "./result_8chains/node478_3_1.txt 87"
    "./result_8chains/node478_4_1.txt 86"
    "./result_8chains/node478_5_1.txt 85"
    "./result_8chains/node478_6_1.txt 84"
    "./result_8chains/node478_7_1.txt 83"
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
