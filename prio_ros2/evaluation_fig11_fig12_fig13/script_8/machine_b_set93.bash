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
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_1 -p 260 -st topic93_0_0 -pt topic93_0_1 -u 0.02209942217466998 > ./result_8chains/node93_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_1 -p 356 -st topic93_1_0 -pt topic93_1_1 -u 0.0020526489185662133 > ./result_8chains/node93_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_1 -p 388 -st topic93_2_0 -pt topic93_2_1 -u 0.027487437179104235 > ./result_8chains/node93_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_1 -p 402 -st topic93_3_0 -pt topic93_3_1 -u 0.013084599426456622 > ./result_8chains/node93_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_1 -p 439 -st topic93_4_0 -pt topic93_4_1 -u 0.010729377125481526 > ./result_8chains/node93_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_1 -p 622 -st topic93_5_0 -pt topic93_5_1 -u 0.012611546382000793 > ./result_8chains/node93_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_6_1 -p 788 -st topic93_6_0 -pt topic93_6_1 -u 0.02809108041820188 > ./result_8chains/node93_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_7_1 -p 795 -st topic93_7_0 -pt topic93_7_1 -u 0.09392636267468958 > ./result_8chains/node93_7_1.txt &
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
    "./result_8chains/node93_0_1.txt 90"
    "./result_8chains/node93_1_1.txt 89"
    "./result_8chains/node93_2_1.txt 88"
    "./result_8chains/node93_3_1.txt 87"
    "./result_8chains/node93_4_1.txt 86"
    "./result_8chains/node93_5_1.txt 85"
    "./result_8chains/node93_6_1.txt 84"
    "./result_8chains/node93_7_1.txt 83"
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
