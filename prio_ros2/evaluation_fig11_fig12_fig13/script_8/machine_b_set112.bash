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
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_1 -p 35 -st topic112_0_0 -pt topic112_0_1 -u 0.0013081323846340642 > ./result_8chains/node112_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_1 -p 316 -st topic112_1_0 -pt topic112_1_1 -u 0.01119155623399326 > ./result_8chains/node112_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_1 -p 391 -st topic112_2_0 -pt topic112_2_1 -u 0.0006712863140385106 > ./result_8chains/node112_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_1 -p 399 -st topic112_3_0 -pt topic112_3_1 -u 0.021838543612329675 > ./result_8chains/node112_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_1 -p 507 -st topic112_4_0 -pt topic112_4_1 -u 0.009694831074741672 > ./result_8chains/node112_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_1 -p 530 -st topic112_5_0 -pt topic112_5_1 -u 0.0052833970975280364 > ./result_8chains/node112_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_1 -p 541 -st topic112_6_0 -pt topic112_6_1 -u 0.012366232369425134 > ./result_8chains/node112_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_1 -p 845 -st topic112_7_0 -pt topic112_7_1 -u 0.0013739524156551608 > ./result_8chains/node112_7_1.txt &
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
    "./result_8chains/node112_0_1.txt 90"
    "./result_8chains/node112_1_1.txt 89"
    "./result_8chains/node112_2_1.txt 88"
    "./result_8chains/node112_3_1.txt 87"
    "./result_8chains/node112_4_1.txt 86"
    "./result_8chains/node112_5_1.txt 85"
    "./result_8chains/node112_6_1.txt 84"
    "./result_8chains/node112_7_1.txt 83"
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
