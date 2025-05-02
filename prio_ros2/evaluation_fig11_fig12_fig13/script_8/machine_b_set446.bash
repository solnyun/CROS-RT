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
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_1 -p 170 -st topic446_0_0 -pt topic446_0_1 -u 0.027763395654979095 > ./result_8chains/node446_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_1 -p 183 -st topic446_1_0 -pt topic446_1_1 -u 0.004249636217952879 > ./result_8chains/node446_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_1 -p 280 -st topic446_2_0 -pt topic446_2_1 -u 0.029229810216412522 > ./result_8chains/node446_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_1 -p 370 -st topic446_3_0 -pt topic446_3_1 -u 0.009816680086236207 > ./result_8chains/node446_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_1 -p 710 -st topic446_4_0 -pt topic446_4_1 -u 0.022801689569571626 > ./result_8chains/node446_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_1 -p 716 -st topic446_5_0 -pt topic446_5_1 -u 0.0031813386464527305 > ./result_8chains/node446_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_1 -p 827 -st topic446_6_0 -pt topic446_6_1 -u 0.019131360397801764 > ./result_8chains/node446_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_1 -p 979 -st topic446_7_0 -pt topic446_7_1 -u 0.024091063766458542 > ./result_8chains/node446_7_1.txt &
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
    "./result_8chains/node446_0_1.txt 90"
    "./result_8chains/node446_1_1.txt 89"
    "./result_8chains/node446_2_1.txt 88"
    "./result_8chains/node446_3_1.txt 87"
    "./result_8chains/node446_4_1.txt 86"
    "./result_8chains/node446_5_1.txt 85"
    "./result_8chains/node446_6_1.txt 84"
    "./result_8chains/node446_7_1.txt 83"
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
