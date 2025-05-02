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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_1 -p 37 -st topic252_0_0 -pt topic252_0_1 -u 0.0030569232801564983 > ./result_8chains/node252_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_1 -p 330 -st topic252_1_0 -pt topic252_1_1 -u 0.027618591775641466 > ./result_8chains/node252_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_1 -p 407 -st topic252_2_0 -pt topic252_2_1 -u 0.0068804225879599 > ./result_8chains/node252_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_1 -p 459 -st topic252_3_0 -pt topic252_3_1 -u 0.06487598544217005 > ./result_8chains/node252_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_1 -p 633 -st topic252_4_0 -pt topic252_4_1 -u 0.0457047752106661 > ./result_8chains/node252_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_1 -p 784 -st topic252_5_0 -pt topic252_5_1 -u 0.00806916771535314 > ./result_8chains/node252_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_1 -p 826 -st topic252_6_0 -pt topic252_6_1 -u 0.030482680979600357 > ./result_8chains/node252_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_1 -p 860 -st topic252_7_0 -pt topic252_7_1 -u 0.005624344832368025 > ./result_8chains/node252_7_1.txt &
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
    "./result_8chains/node252_0_1.txt 90"
    "./result_8chains/node252_1_1.txt 89"
    "./result_8chains/node252_2_1.txt 88"
    "./result_8chains/node252_3_1.txt 87"
    "./result_8chains/node252_4_1.txt 86"
    "./result_8chains/node252_5_1.txt 85"
    "./result_8chains/node252_6_1.txt 84"
    "./result_8chains/node252_7_1.txt 83"
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
