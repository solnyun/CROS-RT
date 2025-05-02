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
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_1 -p 43 -st topic194_0_0 -pt topic194_0_1 -u 0.0048797602747039925 > ./result_8chains/node194_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_1 -p 145 -st topic194_1_0 -pt topic194_1_1 -u 0.03321634821308911 > ./result_8chains/node194_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_1 -p 147 -st topic194_2_0 -pt topic194_2_1 -u 0.0029678892573904436 > ./result_8chains/node194_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_1 -p 399 -st topic194_3_0 -pt topic194_3_1 -u 0.0051396800255023856 > ./result_8chains/node194_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_1 -p 631 -st topic194_4_0 -pt topic194_4_1 -u 0.008625405350037557 > ./result_8chains/node194_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_1 -p 663 -st topic194_5_0 -pt topic194_5_1 -u 0.013595923137926264 > ./result_8chains/node194_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_1 -p 677 -st topic194_6_0 -pt topic194_6_1 -u 0.031054838566196216 > ./result_8chains/node194_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_1 -p 812 -st topic194_7_0 -pt topic194_7_1 -u 0.011548647956466592 > ./result_8chains/node194_7_1.txt &
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
    "./result_8chains/node194_0_1.txt 90"
    "./result_8chains/node194_1_1.txt 89"
    "./result_8chains/node194_2_1.txt 88"
    "./result_8chains/node194_3_1.txt 87"
    "./result_8chains/node194_4_1.txt 86"
    "./result_8chains/node194_5_1.txt 85"
    "./result_8chains/node194_6_1.txt 84"
    "./result_8chains/node194_7_1.txt 83"
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
